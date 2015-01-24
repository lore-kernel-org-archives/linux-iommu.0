From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: Trouble with R-Car IPMMU and DMAC (help needed)
Date: Sun, 25 Jan 2015 00:19:13 +0200
Message-ID: <1422137953-30156-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <2062762.kGCMsinYPp@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2062762.kGCMsinYPp@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: iommu@lists.linux-foundation.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Hello,

I've tried once more to fix the IPMMU problem I've reported 6 months ag=
o,
without much more luck than last time. Here's a bit more information in=
 the
hope it could ring a bell, somewhere.

A quick summary first. I want to enable IOMMU support for the R-Car Gen=
2
system DMA controller (DMAC). The rcar-dmac driver and DT support for t=
he
ipmmu-vmsa driver will be be merged upstream in v3.20. My working branc=
h is
available at

	git://linuxtv.org/pinchartl/fbdev.git dma/iommu/next

While stress-testing the DMA driver with dmatest I've noticed random
failures. I managed to produce a smaller test case in the form of a hac=
ked
dmatest driver. Both the failures and the test case are described in
http://www.spinics.net/lists/linux-sh/msg34034.html.

I've simplified the test case code further compared to the previous ver=
sion
while keeping the same logic. I have included it below as a patch for
dmatest.c and pushed it to the dma/iommu/debug branch of the above-ment=
ioned
repository.

The test now takes two parameters, channel and device, that allow filte=
ring
DMA channels based on the channel and device name. Valid values for the
channel parameter are dma[01]chan([0-9]|1[0-4]). This has allowed me to=
 test
all DMA channels, and to notice that the problem only occurs for channe=
l 0 of
the dmac0 controller, connected to =C2=B5TLB 0 of the IPMMU.

The dma/iommu/debug branch contains more debugging patches to

- add IPMMU performance monitoring support
- add logging to the rcar-dmac and ipmmu-vmsa drivers
- test other TLB invalidation and page table flush methods

None of those tests had any visible effect on the issue. Performance
monitoring could help understanding the problem better by reporting the=
 number
of L2 and L3 misses, but isn't support by the SoCs I currently have acc=
ess to.

---
[PATCH] [DEBUG - DON'T APPLY] dmaengine: dmatest: IOMMU TLB test
---
 drivers/dma/dmatest.c | 1105 ++++++++++++-----------------------------=
--------
 1 file changed, 261 insertions(+), 844 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index a8d7809e2f4c..b5ca559e1eb6 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -9,976 +9,393 @@
  * published by the Free Software Foundation.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define DEBUG
=20
-#include <linux/delay.h>
+#include <linux/completion.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/freezer.h>
 #include <linux/init.h>
-#include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/random.h>
 #include <linux/slab.h>
-#include <linux/wait.h>
-
-static unsigned int test_buf_size =3D 16384;
-module_param(test_buf_size, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(test_buf_size, "Size of the memcpy test buffer");
+#include <asm/cacheflush.h>
=20
 static char test_channel[20];
 module_param_string(channel, test_channel, sizeof(test_channel),
-		S_IRUGO | S_IWUSR);
+		    S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(channel, "Bus ID of the channel to test (default: any=
)");
=20
 static char test_device[32];
 module_param_string(device, test_device, sizeof(test_device),
-		S_IRUGO | S_IWUSR);
+		    S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(device, "Bus ID of the DMA Engine to test (default: a=
ny)");
=20
-static unsigned int threads_per_chan =3D 1;
-module_param(threads_per_chan, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(threads_per_chan,
-		"Number of threads to start per channel (default: 1)");
-
-static unsigned int max_channels;
-module_param(max_channels, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(max_channels,
-		"Maximum number of channels to use (default: all)");
-
-static unsigned int iterations;
-module_param(iterations, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(iterations,
-		"Iterations before stopping test (default: infinite)");
-
-static unsigned int xor_sources =3D 3;
-module_param(xor_sources, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(xor_sources,
-		"Number of xor source buffers (default: 3)");
-
-static unsigned int pq_sources =3D 3;
-module_param(pq_sources, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(pq_sources,
-		"Number of p+q source buffers (default: 3)");
-
-static int timeout =3D 3000;
-module_param(timeout, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(timeout, "Transfer Timeout in msec (default: 3000), "
-		 "Pass -1 for infinite timeout");
-
-static bool noverify;
-module_param(noverify, bool, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(noverify, "Disable random data setup and verification=
");
-
-static bool verbose;
-module_param(verbose, bool, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(verbose, "Enable \"success\" result messages (default=
: off)");
-
-/**
- * struct dmatest_params - test parameters.
- * @buf_size:		size of the memcpy test buffer
- * @channel:		bus ID of the channel to test
- * @device:		bus ID of the DMA Engine to test
- * @threads_per_chan:	number of threads to start per channel
- * @max_channels:	maximum number of channels to use
- * @iterations:		iterations before stopping test
- * @xor_sources:	number of xor source buffers
- * @pq_sources:		number of p+q source buffers
- * @timeout:		transfer timeout in msec, -1 for infinite timeout
- */
-struct dmatest_params {
-	unsigned int	buf_size;
-	char		channel[20];
-	char		device[32];
-	unsigned int	threads_per_chan;
-	unsigned int	max_channels;
-	unsigned int	iterations;
-	unsigned int	xor_sources;
-	unsigned int	pq_sources;
-	int		timeout;
-	bool		noverify;
-};
-
-/**
- * struct dmatest_info - test information.
- * @params:		test parameters
- * @lock:		access protection to the fields of this structure
- */
-static struct dmatest_info {
-	/* Test parameters */
-	struct dmatest_params	params;
-
-	/* Internal state */
-	struct list_head	channels;
-	unsigned int		nr_channels;
-	struct mutex		lock;
-	bool			did_init;
-} test_info =3D {
-	.channels =3D LIST_HEAD_INIT(test_info.channels),
-	.lock =3D __MUTEX_INITIALIZER(test_info.lock),
-};
-
-static int dmatest_run_set(const char *val, const struct kernel_param =
*kp);
-static int dmatest_run_get(char *val, const struct kernel_param *kp);
-static struct kernel_param_ops run_ops =3D {
-	.set =3D dmatest_run_set,
-	.get =3D dmatest_run_get,
+enum dmatest_buf_type {
+	BUF_SRC =3D 0,
+	BUF_DST =3D 1,
 };
-static bool dmatest_run;
-module_param_cb(run, &run_ops, &dmatest_run, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(run, "Run the test (default: false)");
=20
-/* Maximum amount of mismatched bytes in buffer to print */
-#define MAX_ERROR_COUNT		32
+#define SRC_COUNT		(4)
+#define DST_COUNT		(9 + 4)
=20
-/*
- * Initialization patterns. All bytes in the source buffer has bit 7
- * set, all bytes in the destination buffer has bit 7 cleared.
- *
- * Bit 6 is set for all bytes which are to be copied by the DMA
- * engine. Bit 5 is set for all bytes which are to be overwritten by
- * the DMA engine.
- *
- * The remaining bits are the inverse of a counter which increments by
- * one for each byte address.
- */
-#define PATTERN_SRC		0x80
-#define PATTERN_DST		0x00
-#define PATTERN_COPY		0x40
-#define PATTERN_OVERWRITE	0x20
-#define PATTERN_COUNT_MASK	0x1f
-
-struct dmatest_thread {
-	struct list_head	node;
-	struct dmatest_info	*info;
-	struct task_struct	*task;
+struct dmatest_info {
 	struct dma_chan		*chan;
-	u8			**srcs;
-	u8			**dsts;
-	enum dma_transaction_type type;
-	bool			done;
-};
+	struct completion	done;
=20
-struct dmatest_chan {
-	struct list_head	node;
-	struct dma_chan		*chan;
-	struct list_head	threads;
+	u8			*srcs[SRC_COUNT];
+	u8			*dsts[DST_COUNT];
+	dma_addr_t		src_dmas[SRC_COUNT];
+	dma_addr_t		dst_dmas[DST_COUNT];
 };
=20
-static DECLARE_WAIT_QUEUE_HEAD(thread_wait);
-static bool wait;
-
-static bool is_threaded_test_run(struct dmatest_info *info)
+static int dmatest_verify(struct dmatest_info *info, unsigned int inde=
x,
+			   u8 expected, bool print_success)
 {
-	struct dmatest_chan *dtc;
+	u8 *buf =3D info->dsts[index];
+	unsigned int i;
=20
-	list_for_each_entry(dtc, &info->channels, node) {
-		struct dmatest_thread *thread;
+	/* Definitely overkill, but just to be safe. */
+	flush_cache_all();
=20
-		list_for_each_entry(thread, &dtc->threads, node) {
-			if (!thread->done)
-				return true;
+	for (i =3D 0; i < PAGE_SIZE; ++i) {
+		if (buf[i] !=3D expected) {
+			pr_info("%s: dst[%u] mismatch @%u: got %u expected %u\n",
+				__func__, index, i, buf[i], expected);
+			return 1;
 		}
 	}
=20
-	return false;
-}
-
-static int dmatest_wait_get(char *val, const struct kernel_param *kp)
-{
-	struct dmatest_info *info =3D &test_info;
-	struct dmatest_params *params =3D &info->params;
+	if (print_success)
+		pr_info("%s: dst[%u] verified, contains %u\n", __func__,
+			index, expected);
=20
-	if (params->iterations)
-		wait_event(thread_wait, !is_threaded_test_run(info));
-	wait =3D true;
-	return param_get_bool(val, kp);
+	return 0;
 }
=20
-static struct kernel_param_ops wait_ops =3D {
-	.get =3D dmatest_wait_get,
-	.set =3D param_set_bool,
-};
-module_param_cb(wait, &wait_ops, &wait, S_IRUGO);
-MODULE_PARM_DESC(wait, "Wait for tests to complete (default: false)");
-
-static bool dmatest_match_channel(struct dmatest_params *params,
-		struct dma_chan *chan)
+static void dmatest_callback(void *arg)
 {
-	if (params->channel[0] =3D=3D '\0')
-		return true;
-	return strcmp(dma_chan_name(chan), params->channel) =3D=3D 0;
+	struct dmatest_info *info =3D arg;
+
+	complete(&info->done);
 }
=20
-static bool dmatest_match_device(struct dmatest_params *params,
-		struct dma_device *device)
+static void result(const char *err, unsigned long data)
 {
-	if (params->device[0] =3D=3D '\0')
-		return true;
-	return strcmp(dev_name(device->dev), params->device) =3D=3D 0;
+	pr_info("%s: result: '%s' (%lu)\n", current->comm, err, data);
 }
=20
-static unsigned long dmatest_random(void)
+static int dmatest_map(struct dmatest_info *info,
+		       enum dmatest_buf_type type, unsigned int index)
 {
-	unsigned long buf;
+	struct device *dev =3D info->chan->device->dev;
+	enum dma_data_direction dir;
+	dma_addr_t dma;
+	void *buf;
+	int ret;
=20
-	prandom_bytes(&buf, sizeof(buf));
-	return buf;
-}
+	pr_debug("%s: mapping %s %u\n", __func__,
+		 type =3D=3D BUF_SRC ? "src" : "dst", index);
=20
-static void dmatest_init_srcs(u8 **bufs, unsigned int start, unsigned =
int len,
-		unsigned int buf_size)
-{
-	unsigned int i;
-	u8 *buf;
-
-	for (; (buf =3D *bufs); bufs++) {
-		for (i =3D 0; i < start; i++)
-			buf[i] =3D PATTERN_SRC | (~i & PATTERN_COUNT_MASK);
-		for ( ; i < start + len; i++)
-			buf[i] =3D PATTERN_SRC | PATTERN_COPY
-				| (~i & PATTERN_COUNT_MASK);
-		for ( ; i < buf_size; i++)
-			buf[i] =3D PATTERN_SRC | (~i & PATTERN_COUNT_MASK);
-		buf++;
+	if (type =3D=3D BUF_SRC) {
+		buf =3D info->srcs[index];
+		dir =3D DMA_TO_DEVICE;
+	} else {
+		buf =3D info->dsts[index];
+		dir =3D DMA_BIDIRECTIONAL;
 	}
-}
=20
-static void dmatest_init_dsts(u8 **bufs, unsigned int start, unsigned =
int len,
-		unsigned int buf_size)
-{
-	unsigned int i;
-	u8 *buf;
-
-	for (; (buf =3D *bufs); bufs++) {
-		for (i =3D 0; i < start; i++)
-			buf[i] =3D PATTERN_DST | (~i & PATTERN_COUNT_MASK);
-		for ( ; i < start + len; i++)
-			buf[i] =3D PATTERN_DST | PATTERN_OVERWRITE
-				| (~i & PATTERN_COUNT_MASK);
-		for ( ; i < buf_size; i++)
-			buf[i] =3D PATTERN_DST | (~i & PATTERN_COUNT_MASK);
+	dma =3D dma_map_page(dev, virt_to_page(buf), 0, PAGE_SIZE, dir);
+	ret =3D dma_mapping_error(dev, dma);
+	if (ret) {
+		result("dma mapping error", ret);
+		return ret;
 	}
-}
=20
-static void dmatest_mismatch(u8 actual, u8 pattern, unsigned int index=
,
-		unsigned int counter, bool is_srcbuf)
-{
-	u8		diff =3D actual ^ pattern;
-	u8		expected =3D pattern | (~counter & PATTERN_COUNT_MASK);
-	const char	*thread_name =3D current->comm;
-
-	if (is_srcbuf)
-		pr_warn("%s: srcbuf[0x%x] overwritten! Expected %02x, got %02x\n",
-			thread_name, index, expected, actual);
-	else if ((pattern & PATTERN_COPY)
-			&& (diff & (PATTERN_COPY | PATTERN_OVERWRITE)))
-		pr_warn("%s: dstbuf[0x%x] not copied! Expected %02x, got %02x\n",
-			thread_name, index, expected, actual);
-	else if (diff & PATTERN_SRC)
-		pr_warn("%s: dstbuf[0x%x] was copied! Expected %02x, got %02x\n",
-			thread_name, index, expected, actual);
+	if (type =3D=3D BUF_SRC)
+		info->src_dmas[index] =3D dma;
 	else
-		pr_warn("%s: dstbuf[0x%x] mismatch! Expected %02x, got %02x\n",
-			thread_name, index, expected, actual);
+		info->dst_dmas[index] =3D dma;
+
+	return 0;
 }
=20
-static unsigned int dmatest_verify(u8 **bufs, unsigned int start,
-		unsigned int end, unsigned int counter, u8 pattern,
-		bool is_srcbuf)
+static void dmatest_unmap(struct dmatest_info *info,
+			  enum dmatest_buf_type type, unsigned int index)
 {
-	unsigned int i;
-	unsigned int error_count =3D 0;
-	u8 actual;
-	u8 expected;
-	u8 *buf;
-	unsigned int counter_orig =3D counter;
-
-	for (; (buf =3D *bufs); bufs++) {
-		counter =3D counter_orig;
-		for (i =3D start; i < end; i++) {
-			actual =3D buf[i];
-			expected =3D pattern | (~counter & PATTERN_COUNT_MASK);
-			if (actual !=3D expected) {
-				if (error_count < MAX_ERROR_COUNT)
-					dmatest_mismatch(actual, pattern, i,
-							 counter, is_srcbuf);
-				error_count++;
-			}
-			counter++;
-		}
-	}
+	struct device *dev =3D info->chan->device->dev;
+	enum dma_data_direction dir;
+	dma_addr_t dma;
=20
-	if (error_count > MAX_ERROR_COUNT)
-		pr_warn("%s: %u errors suppressed\n",
-			current->comm, error_count - MAX_ERROR_COUNT);
-
-	return error_count;
-}
+	pr_debug("%s: unmapping %s %u\n", __func__,
+		 type =3D=3D BUF_SRC ? "src" : "dst", index);
=20
-/* poor man's completion - we want to use wait_event_freezable() on it=
 */
-struct dmatest_done {
-	bool			done;
-	wait_queue_head_t	*wait;
-};
+	if (type =3D=3D BUF_SRC) {
+		dir =3D DMA_TO_DEVICE;
+		dma =3D info->src_dmas[index];
+		info->src_dmas[index] =3D DMA_ERROR_CODE;
+	} else {
+		dir =3D DMA_BIDIRECTIONAL;
+		dma =3D info->dst_dmas[index];
+		info->dst_dmas[index] =3D DMA_ERROR_CODE;
+	}
=20
-static void dmatest_callback(void *arg)
-{
-	struct dmatest_done *done =3D arg;
+	if (dma_mapping_error(dev, dma))
+		return;
=20
-	done->done =3D true;
-	wake_up_all(done->wait);
+	dma_unmap_page(dev, dma, PAGE_SIZE, dir);
 }
=20
-static unsigned int min_odd(unsigned int x, unsigned int y)
+static int dmatest_alloc_buffers(struct dmatest_info *info)
 {
-	unsigned int val =3D min(x, y);
+	unsigned int i;
=20
-	return val % 2 ? val : val - 1;
-}
+	for (i =3D 0; i < SRC_COUNT; i++) {
+		info->srcs[i] =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
+		pr_debug("%s: allocated src buffer %u @0x%p\n", __func__, i, info->s=
rcs[i]);
+		if (!info->srcs[i])
+			return -ENOMEM;
+		if ((unsigned long)info->srcs[i] & ~PAGE_MASK)
+			return -EINVAL;
+		memset(info->srcs[i], i, PAGE_SIZE);
+		info->src_dmas[i] =3D DMA_ERROR_CODE;
+	}
=20
-static void result(const char *err, unsigned int n, unsigned int src_o=
ff,
-		   unsigned int dst_off, unsigned int len, unsigned long data)
-{
-	pr_info("%s: result #%u: '%s' with src_off=3D0x%x dst_off=3D0x%x len=3D=
0x%x (%lu)\n",
-		current->comm, n, err, src_off, dst_off, len, data);
-}
+	for (i =3D 0; i < DST_COUNT; i++) {
+		info->dsts[i] =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
+		pr_debug("%s: allocated dst buffer %u @0x%p\n", __func__, i, info->d=
sts[i]);
+		if (!info->dsts[i])
+			return -ENOMEM;
+		if ((unsigned long)info->dsts[i] & ~PAGE_MASK)
+			return -EINVAL;
+		memset(info->dsts[i], 255 - i, PAGE_SIZE);
+		info->dst_dmas[i] =3D DMA_ERROR_CODE;
+	}
=20
-static void dbg_result(const char *err, unsigned int n, unsigned int s=
rc_off,
-		       unsigned int dst_off, unsigned int len,
-		       unsigned long data)
-{
-	pr_debug("%s: result #%u: '%s' with src_off=3D0x%x dst_off=3D0x%x len=
=3D0x%x (%lu)\n",
-		   current->comm, n, err, src_off, dst_off, len, data);
+	return 0;
 }
=20
-#define verbose_result(err, n, src_off, dst_off, len, data) ({ \
-	if (verbose) \
-		result(err, n, src_off, dst_off, len, data); \
-	else \
-		dbg_result(err, n, src_off, dst_off, len, data); \
-})
-
-static unsigned long long dmatest_persec(s64 runtime, unsigned int val=
)
+static void dmatest_free_buffers(struct dmatest_info *info)
 {
-	unsigned long long per_sec =3D 1000000;
-
-	if (runtime <=3D 0)
-		return 0;
+	unsigned int i;
=20
-	/* drop precision until runtime is 32-bits */
-	while (runtime > UINT_MAX) {
-		runtime >>=3D 1;
-		per_sec <<=3D 1;
+	for (i =3D 0; i < SRC_COUNT; i++) {
+		dmatest_unmap(info, BUF_SRC, i);
+		kfree(info->srcs[i]);
 	}
=20
-	per_sec *=3D val;
-	do_div(per_sec, runtime);
-	return per_sec;
-}
-
-static unsigned long long dmatest_KBs(s64 runtime, unsigned long long =
len)
-{
-	return dmatest_persec(runtime, len >> 10);
+	for (i =3D 0; i < DST_COUNT; i++) {
+		dmatest_unmap(info, BUF_DST, i);
+		kfree(info->dsts[i]);
+	}
 }
=20
-/*
- * This function repeatedly tests DMA transfers of various lengths and
- * offsets for a given operation type until it is told to exit by
- * kthread_stop(). There may be multiple threads running this function
- * in parallel for a single channel, and there may be multiple channel=
s
- * being tested in parallel.
- *
- * Before each test, the source and destination buffer is initialized
- * with a known pattern. This pattern is different depending on
- * whether it's in an area which is supposed to be copied or
- * overwritten, and different in the source and destination buffers.
- * So if the DMA engine doesn't copy exactly what we tell it to copy,
- * we'll notice.
- */
-static int dmatest_func(void *data)
+static int dmatest_memcpy(struct dmatest_info *info, unsigned int src,
+			  unsigned int dst)
 {
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(done_wait);
-	struct dmatest_thread	*thread =3D data;
-	struct dmatest_done	done =3D { .wait =3D &done_wait };
-	struct dmatest_info	*info;
-	struct dmatest_params	*params;
-	struct dma_chan		*chan;
-	struct dma_device	*dev;
-	unsigned int		src_off, dst_off, len;
-	unsigned int		error_count;
-	unsigned int		failed_tests =3D 0;
-	unsigned int		total_tests =3D 0;
-	dma_cookie_t		cookie;
-	enum dma_status		status;
-	enum dma_ctrl_flags 	flags;
-	u8			*pq_coefs =3D NULL;
-	int			ret;
-	int			src_cnt;
-	int			dst_cnt;
-	int			i;
-	ktime_t			ktime;
-	s64			runtime =3D 0;
-	unsigned long long	total_len =3D 0;
-
-	set_freezable();
-
-	ret =3D -ENOMEM;
-
-	smp_rmb();
-	info =3D thread->info;
-	params =3D &info->params;
-	chan =3D thread->chan;
-	dev =3D chan->device;
-	if (thread->type =3D=3D DMA_MEMCPY)
-		src_cnt =3D dst_cnt =3D 1;
-	else if (thread->type =3D=3D DMA_XOR) {
-		/* force odd to ensure dst =3D src */
-		src_cnt =3D min_odd(params->xor_sources | 1, dev->max_xor);
-		dst_cnt =3D 1;
-	} else if (thread->type =3D=3D DMA_PQ) {
-		/* force odd to ensure dst =3D src */
-		src_cnt =3D min_odd(params->pq_sources | 1, dma_maxpq(dev, 0));
-		dst_cnt =3D 2;
-
-		pq_coefs =3D kmalloc(params->pq_sources+1, GFP_KERNEL);
-		if (!pq_coefs)
-			goto err_thread_type;
-
-		for (i =3D 0; i < src_cnt; i++)
-			pq_coefs[i] =3D 1;
-	} else
-		goto err_thread_type;
-
-	thread->srcs =3D kcalloc(src_cnt+1, sizeof(u8 *), GFP_KERNEL);
-	if (!thread->srcs)
-		goto err_srcs;
-	for (i =3D 0; i < src_cnt; i++) {
-		thread->srcs[i] =3D kmalloc(params->buf_size, GFP_KERNEL);
-		if (!thread->srcs[i])
-			goto err_srcbuf;
-	}
-	thread->srcs[i] =3D NULL;
-
-	thread->dsts =3D kcalloc(dst_cnt+1, sizeof(u8 *), GFP_KERNEL);
-	if (!thread->dsts)
-		goto err_dsts;
-	for (i =3D 0; i < dst_cnt; i++) {
-		thread->dsts[i] =3D kmalloc(params->buf_size, GFP_KERNEL);
-		if (!thread->dsts[i])
-			goto err_dstbuf;
+	struct dma_chan *chan =3D info->chan;
+	struct dma_device *dev =3D chan->device;
+	struct dma_async_tx_descriptor *tx;
+	enum dma_status status;
+	unsigned long timeout;
+	dma_cookie_t cookie;
+
+	tx =3D dev->device_prep_dma_memcpy(chan, info->dst_dmas[dst],
+					 info->src_dmas[src], PAGE_SIZE,
+					 DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	if (!tx) {
+		result("prep error", 0);
+		return -EIO;
 	}
-	thread->dsts[i] =3D NULL;
-
-	set_user_nice(current, 10);
-
-	/*
-	 * src and dst buffers are freed by ourselves below
-	 */
-	flags =3D DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
-
-	ktime =3D ktime_get();
-	while (!kthread_should_stop()
-	       && !(params->iterations && total_tests >=3D params->iterations=
)) {
-		struct dma_async_tx_descriptor *tx =3D NULL;
-		struct dmaengine_unmap_data *um;
-		dma_addr_t srcs[src_cnt];
-		dma_addr_t *dsts;
-		u8 align =3D 0;
-
-		total_tests++;
-
-		/* honor alignment restrictions */
-		if (thread->type =3D=3D DMA_MEMCPY)
-			align =3D dev->copy_align;
-		else if (thread->type =3D=3D DMA_XOR)
-			align =3D dev->xor_align;
-		else if (thread->type =3D=3D DMA_PQ)
-			align =3D dev->pq_align;
-
-		if (1 << align > params->buf_size) {
-			pr_err("%u-byte buffer too small for %d-byte alignment\n",
-			       params->buf_size, 1 << align);
-			break;
-		}
=20
-		if (params->noverify) {
-			len =3D params->buf_size;
-			src_off =3D 0;
-			dst_off =3D 0;
-		} else {
-			len =3D dmatest_random() % params->buf_size + 1;
-			len =3D (len >> align) << align;
-			if (!len)
-				len =3D 1 << align;
-			src_off =3D dmatest_random() % (params->buf_size - len + 1);
-			dst_off =3D dmatest_random() % (params->buf_size - len + 1);
-
-			src_off =3D (src_off >> align) << align;
-			dst_off =3D (dst_off >> align) << align;
-
-			dmatest_init_srcs(thread->srcs, src_off, len,
-					  params->buf_size);
-			dmatest_init_dsts(thread->dsts, dst_off, len,
-					  params->buf_size);
-		}
+	reinit_completion(&info->done);
=20
-		len =3D (len >> align) << align;
-		if (!len)
-			len =3D 1 << align;
-		total_len +=3D len;
-
-		um =3D dmaengine_get_unmap_data(dev->dev, src_cnt+dst_cnt,
-					      GFP_KERNEL);
-		if (!um) {
-			failed_tests++;
-			result("unmap data NULL", total_tests,
-			       src_off, dst_off, len, ret);
-			continue;
-		}
-
-		um->len =3D params->buf_size;
-		for (i =3D 0; i < src_cnt; i++) {
-			void *buf =3D thread->srcs[i];
-			struct page *pg =3D virt_to_page(buf);
-			unsigned pg_off =3D (unsigned long) buf & ~PAGE_MASK;
-
-			um->addr[i] =3D dma_map_page(dev->dev, pg, pg_off,
-						   um->len, DMA_TO_DEVICE);
-			srcs[i] =3D um->addr[i] + src_off;
-			ret =3D dma_mapping_error(dev->dev, um->addr[i]);
-			if (ret) {
-				dmaengine_unmap_put(um);
-				result("src mapping error", total_tests,
-				       src_off, dst_off, len, ret);
-				failed_tests++;
-				continue;
-			}
-			um->to_cnt++;
-		}
-		/* map with DMA_BIDIRECTIONAL to force writeback/invalidate */
-		dsts =3D &um->addr[src_cnt];
-		for (i =3D 0; i < dst_cnt; i++) {
-			void *buf =3D thread->dsts[i];
-			struct page *pg =3D virt_to_page(buf);
-			unsigned pg_off =3D (unsigned long) buf & ~PAGE_MASK;
-
-			dsts[i] =3D dma_map_page(dev->dev, pg, pg_off, um->len,
-					       DMA_BIDIRECTIONAL);
-			ret =3D dma_mapping_error(dev->dev, dsts[i]);
-			if (ret) {
-				dmaengine_unmap_put(um);
-				result("dst mapping error", total_tests,
-				       src_off, dst_off, len, ret);
-				failed_tests++;
-				continue;
-			}
-			um->bidi_cnt++;
-		}
+	tx->callback =3D dmatest_callback;
+	tx->callback_param =3D info;
+	cookie =3D tx->tx_submit(tx);
=20
-		if (thread->type =3D=3D DMA_MEMCPY)
-			tx =3D dev->device_prep_dma_memcpy(chan,
-							 dsts[0] + dst_off,
-							 srcs[0], len, flags);
-		else if (thread->type =3D=3D DMA_XOR)
-			tx =3D dev->device_prep_dma_xor(chan,
-						      dsts[0] + dst_off,
-						      srcs, src_cnt,
-						      len, flags);
-		else if (thread->type =3D=3D DMA_PQ) {
-			dma_addr_t dma_pq[dst_cnt];
-
-			for (i =3D 0; i < dst_cnt; i++)
-				dma_pq[i] =3D dsts[i] + dst_off;
-			tx =3D dev->device_prep_dma_pq(chan, dma_pq, srcs,
-						     src_cnt, pq_coefs,
-						     len, flags);
-		}
-
-		if (!tx) {
-			dmaengine_unmap_put(um);
-			result("prep error", total_tests, src_off,
-			       dst_off, len, ret);
-			msleep(100);
-			failed_tests++;
-			continue;
-		}
-
-		done.done =3D false;
-		tx->callback =3D dmatest_callback;
-		tx->callback_param =3D &done;
-		cookie =3D tx->tx_submit(tx);
-
-		if (dma_submit_error(cookie)) {
-			dmaengine_unmap_put(um);
-			result("submit error", total_tests, src_off,
-			       dst_off, len, ret);
-			msleep(100);
-			failed_tests++;
-			continue;
-		}
-		dma_async_issue_pending(chan);
-
-		wait_event_freezable_timeout(done_wait, done.done,
-					     msecs_to_jiffies(params->timeout));
-
-		status =3D dma_async_is_tx_complete(chan, cookie, NULL, NULL);
-
-		if (!done.done) {
-			/*
-			 * We're leaving the timed out dma operation with
-			 * dangling pointer to done_wait.  To make this
-			 * correct, we'll need to allocate wait_done for
-			 * each test iteration and perform "who's gonna
-			 * free it this time?" dancing.  For now, just
-			 * leave it dangling.
-			 */
-			dmaengine_unmap_put(um);
-			result("test timed out", total_tests, src_off, dst_off,
-			       len, 0);
-			failed_tests++;
-			continue;
-		} else if (status !=3D DMA_COMPLETE) {
-			dmaengine_unmap_put(um);
-			result(status =3D=3D DMA_ERROR ?
-			       "completion error status" :
-			       "completion busy status", total_tests, src_off,
-			       dst_off, len, ret);
-			failed_tests++;
-			continue;
-		}
-
-		dmaengine_unmap_put(um);
-
-		if (params->noverify) {
-			verbose_result("test passed", total_tests, src_off,
-				       dst_off, len, 0);
-			continue;
-		}
-
-		pr_debug("%s: verifying source buffer...\n", current->comm);
-		error_count =3D dmatest_verify(thread->srcs, 0, src_off,
-				0, PATTERN_SRC, true);
-		error_count +=3D dmatest_verify(thread->srcs, src_off,
-				src_off + len, src_off,
-				PATTERN_SRC | PATTERN_COPY, true);
-		error_count +=3D dmatest_verify(thread->srcs, src_off + len,
-				params->buf_size, src_off + len,
-				PATTERN_SRC, true);
-
-		pr_debug("%s: verifying dest buffer...\n", current->comm);
-		error_count +=3D dmatest_verify(thread->dsts, 0, dst_off,
-				0, PATTERN_DST, false);
-		error_count +=3D dmatest_verify(thread->dsts, dst_off,
-				dst_off + len, src_off,
-				PATTERN_SRC | PATTERN_COPY, false);
-		error_count +=3D dmatest_verify(thread->dsts, dst_off + len,
-				params->buf_size, dst_off + len,
-				PATTERN_DST, false);
-
-		if (error_count) {
-			result("data error", total_tests, src_off, dst_off,
-			       len, error_count);
-			failed_tests++;
-		} else {
-			verbose_result("test passed", total_tests, src_off,
-				       dst_off, len, 0);
-		}
+	if (dma_submit_error(cookie)) {
+		result("submit error", 0);
+		return -EIO;
 	}
-	runtime =3D ktime_us_delta(ktime_get(), ktime);
-
-	ret =3D 0;
-err_dstbuf:
-	for (i =3D 0; thread->dsts[i]; i++)
-		kfree(thread->dsts[i]);
-	kfree(thread->dsts);
-err_dsts:
-err_srcbuf:
-	for (i =3D 0; thread->srcs[i]; i++)
-		kfree(thread->srcs[i]);
-	kfree(thread->srcs);
-err_srcs:
-	kfree(pq_coefs);
-err_thread_type:
-	pr_info("%s: summary %u tests, %u failures %llu iops %llu KB/s (%d)\n=
",
-		current->comm, total_tests, failed_tests,
-		dmatest_persec(runtime, total_tests),
-		dmatest_KBs(runtime, total_len), ret);
-
-	/* terminate all transfers on specified channels */
-	if (ret)
-		dmaengine_terminate_all(chan);
-
-	thread->done =3D true;
-	wake_up(&thread_wait);
+	dma_async_issue_pending(chan);
=20
-	return ret;
-}
-
-static void dmatest_cleanup_channel(struct dmatest_chan *dtc)
-{
-	struct dmatest_thread	*thread;
-	struct dmatest_thread	*_thread;
-	int			ret;
-
-	list_for_each_entry_safe(thread, _thread, &dtc->threads, node) {
-		ret =3D kthread_stop(thread->task);
-		pr_debug("thread %s exited with status %d\n",
-			 thread->task->comm, ret);
-		list_del(&thread->node);
-		put_task_struct(thread->task);
-		kfree(thread);
+	timeout =3D wait_for_completion_timeout(&info->done,
+					      msecs_to_jiffies(3000));
+	if (!timeout) {
+		result("test timed out", 0);
+		return -ETIMEDOUT;
 	}
=20
-	/* terminate all transfers on specified channels */
-	dmaengine_terminate_all(dtc->chan);
+	status =3D dma_async_is_tx_complete(chan, cookie, NULL, NULL);
+	if (status !=3D DMA_COMPLETE) {
+		result(status =3D=3D DMA_ERROR ?
+		       "completion error status" :
+		       "completion busy status", 0);
+		return -EIO;
+	}
=20
-	kfree(dtc);
+	return 0;
 }
=20
-static int dmatest_add_threads(struct dmatest_info *info,
-		struct dmatest_chan *dtc, enum dma_transaction_type type)
+static int dmatest_run(void *data)
 {
-	struct dmatest_params *params =3D &info->params;
-	struct dmatest_thread *thread;
-	struct dma_chan *chan =3D dtc->chan;
-	char *op;
-	unsigned int i;
+	enum dmatest_buf_type trash_type =3D SRC_COUNT > DST_COUNT ? BUF_SRC =
: BUF_DST;
+	enum dmatest_buf_type test_type =3D trash_type;
=20
-	if (type =3D=3D DMA_MEMCPY)
-		op =3D "copy";
-	else if (type =3D=3D DMA_XOR)
-		op =3D "xor";
-	else if (type =3D=3D DMA_PQ)
-		op =3D "pq";
-	else
-		return -EINVAL;
-
-	for (i =3D 0; i < params->threads_per_chan; i++) {
-		thread =3D kzalloc(sizeof(struct dmatest_thread), GFP_KERNEL);
-		if (!thread) {
-			pr_warn("No memory for %s-%s%u\n",
-				dma_chan_name(chan), op, i);
-			break;
-		}
-		thread->info =3D info;
-		thread->chan =3D dtc->chan;
-		thread->type =3D type;
-		smp_wmb();
-		thread->task =3D kthread_create(dmatest_func, thread, "%s-%s%u",
-				dma_chan_name(chan), op, i);
-		if (IS_ERR(thread->task)) {
-			pr_warn("Failed to create thread %s-%s%u\n",
-				dma_chan_name(chan), op, i);
-			kfree(thread);
-			break;
-		}
+	unsigned int trash_count =3D max(SRC_COUNT, DST_COUNT);
+	struct dmatest_info *info =3D data;
+	unsigned int errors =3D 0;
+	unsigned int i;
+	int ret;
=20
-		/* srcbuf and dstbuf are allocated by the thread itself */
-		get_task_struct(thread->task);
-		list_add_tail(&thread->node, &dtc->threads);
-		wake_up_process(thread->task);
-	}
+	/* Allocate the buffers. */
+	ret =3D dmatest_alloc_buffers(info);
+	if (ret < 0)
+		goto error;
=20
-	return i;
-}
+	pr_info("%s: testing %s side\n", __func__,
+		test_type =3D=3D BUF_SRC ? "src" : "dst");
=20
-static int dmatest_add_channel(struct dmatest_info *info,
-		struct dma_chan *chan)
-{
-	struct dmatest_chan	*dtc;
-	struct dma_device	*dma_dev =3D chan->device;
-	unsigned int		thread_count =3D 0;
-	int cnt;
-
-	dtc =3D kmalloc(sizeof(struct dmatest_chan), GFP_KERNEL);
-	if (!dtc) {
-		pr_warn("No memory for %s\n", dma_chan_name(chan));
-		return -ENOMEM;
+	/* map 0 and 1 on the test side and 0-3 on the other side */
+	for (i =3D 0; i < 2; ++i) {
+		ret =3D dmatest_map(info, test_type, i);
+		if (ret < 0)
+			goto error;
 	}
=20
-	dtc->chan =3D chan;
-	INIT_LIST_HEAD(&dtc->threads);
-
-	if (dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask)) {
-		cnt =3D dmatest_add_threads(info, dtc, DMA_MEMCPY);
-		thread_count +=3D cnt > 0 ? cnt : 0;
+	for (i =3D 0; i < 4; ++i) {
+		ret =3D dmatest_map(info, !test_type, i);
+		if (ret < 0)
+			goto error;
 	}
-	if (dma_has_cap(DMA_XOR, dma_dev->cap_mask)) {
-		cnt =3D dmatest_add_threads(info, dtc, DMA_XOR);
-		thread_count +=3D cnt > 0 ? cnt : 0;
+
+	/* map all trash src and dst */
+	for (i =3D 4; i < SRC_COUNT; ++i) {
+		ret =3D dmatest_map(info, BUF_SRC, i);
+		if (ret < 0)
+			goto error;
 	}
-	if (dma_has_cap(DMA_PQ, dma_dev->cap_mask)) {
-		cnt =3D dmatest_add_threads(info, dtc, DMA_PQ);
-		thread_count +=3D cnt > 0 ? cnt : 0;
+
+	for (i =3D 4; i < DST_COUNT; ++i) {
+		ret =3D dmatest_map(info, BUF_DST, i);
+		if (ret < 0)
+			goto error;
 	}
=20
-	pr_info("Started %u threads using %s\n",
-		thread_count, dma_chan_name(chan));
+	/* memcpy 1 -> 1 and verify */
+	pr_info("%s: memcpy 1 -> 1\n", __func__);
+	ret =3D dmatest_memcpy(info, 1, 1);
+	if (ret < 0)
+		goto error;
=20
-	list_add_tail(&dtc->node, &info->channels);
-	info->nr_channels++;
+	errors +=3D dmatest_verify(info, 1, 1, true);
=20
-	return 0;
-}
+	/* unmap test 1 and map test 2 instead */
+	dmatest_unmap(info, test_type, 1);
+	ret =3D dmatest_map(info, test_type, 2);
+	if (ret < 0)
+		goto error;
=20
-static bool filter(struct dma_chan *chan, void *param)
-{
-	struct dmatest_params *params =3D param;
+	/* memcpy 2 -> 2, expect 2 -> 1 or 1 -> 2 in case of failure */
+	pr_info("%s: memcpy 2 -> 2\n", __func__);
+	ret =3D dmatest_memcpy(info, 2, 2);
+	if (ret < 0)
+		goto error;
=20
-	if (!dmatest_match_channel(params, chan) ||
-	    !dmatest_match_device(params, chan->device))
-		return false;
-	else
-		return true;
-}
+	if (test_type =3D=3D BUF_SRC) {
+		errors +=3D dmatest_verify(info, 2, 2, true);
+	} else {
+		errors +=3D dmatest_verify(info, 1, 1, true);
+		errors +=3D dmatest_verify(info, 2, 2, true);
+	}
=20
-static void request_channels(struct dmatest_info *info,
-			     enum dma_transaction_type type)
-{
-	dma_cap_mask_t mask;
+	/* trash the tlb by memcpy all trash buffers */
+	pr_info("%s: trash tlb by memcpy %u %s (4-%u)\n", __func__,
+		trash_count - 4, trash_type =3D=3D BUF_SRC ? "src" : "dst",
+		trash_count - 1);
+	for (i =3D 4; i < trash_count; ++i) {
+		unsigned int src =3D trash_type =3D=3D BUF_SRC ? i : 3;
+		unsigned int dst =3D trash_type =3D=3D BUF_SRC ? 3 : i;
=20
-	dma_cap_zero(mask);
-	dma_cap_set(type, mask);
-	for (;;) {
-		struct dmatest_params *params =3D &info->params;
-		struct dma_chan *chan;
-
-		chan =3D dma_request_channel(mask, filter, params);
-		if (chan) {
-			if (dmatest_add_channel(info, chan)) {
-				dma_release_channel(chan);
-				break; /* add_channel failed, punt */
-			}
-		} else
-			break; /* no more channels available */
-		if (params->max_channels &&
-		    info->nr_channels >=3D params->max_channels)
-			break; /* we have all we need */
+		ret =3D dmatest_memcpy(info, src, dst);
+		if (ret < 0)
+			goto error;
+
+		errors +=3D dmatest_verify(info, dst, src, false);
 	}
-}
=20
-static void run_threaded_test(struct dmatest_info *info)
-{
-	struct dmatest_params *params =3D &info->params;
-
-	/* Copy test parameters */
-	params->buf_size =3D test_buf_size;
-	strlcpy(params->channel, strim(test_channel), sizeof(params->channel)=
);
-	strlcpy(params->device, strim(test_device), sizeof(params->device));
-	params->threads_per_chan =3D threads_per_chan;
-	params->max_channels =3D max_channels;
-	params->iterations =3D iterations;
-	params->xor_sources =3D xor_sources;
-	params->pq_sources =3D pq_sources;
-	params->timeout =3D timeout;
-	params->noverify =3D noverify;
-
-	request_channels(info, DMA_MEMCPY);
-	request_channels(info, DMA_XOR);
-	request_channels(info, DMA_PQ);
-}
+	/* memcpy 2 -> 2, expect 2 -> 2 */
+	pr_info("%s: memcpy 2 -> 2\n", __func__);
+	ret =3D dmatest_memcpy(info, 2, 2);
+	if (ret < 0)
+		goto error;
=20
-static void stop_threaded_test(struct dmatest_info *info)
-{
-	struct dmatest_chan *dtc, *_dtc;
-	struct dma_chan *chan;
-
-	list_for_each_entry_safe(dtc, _dtc, &info->channels, node) {
-		list_del(&dtc->node);
-		chan =3D dtc->chan;
-		dmatest_cleanup_channel(dtc);
-		pr_debug("dropped channel %s\n", dma_chan_name(chan));
-		dma_release_channel(chan);
-	}
+	errors +=3D dmatest_verify(info, 2, 2, true);
=20
-	info->nr_channels =3D 0;
-}
+	ret =3D 0;
=20
-static void restart_threaded_test(struct dmatest_info *info, bool run)
-{
-	/* we might be called early to set run=3D, defer running until all
-	 * parameters have been evaluated
-	 */
-	if (!info->did_init)
-		return;
+error:
+	dmatest_free_buffers(info);
=20
-	/* Stop any running test first */
-	stop_threaded_test(info);
+	pr_info("%s: done (%d), %u errors\n", current->comm, ret, errors);
=20
-	/* Run test with new parameters */
-	run_threaded_test(info);
+	return ret;
 }
=20
-static int dmatest_run_get(char *val, const struct kernel_param *kp)
+static bool dmatest_filter(struct dma_chan *chan, void *param)
 {
-	struct dmatest_info *info =3D &test_info;
+	if (test_device[0] !=3D '\0' &&
+	    strcmp(dev_name(chan->device->dev), test_device))
+		return false;
=20
-	mutex_lock(&info->lock);
-	if (is_threaded_test_run(info)) {
-		dmatest_run =3D true;
-	} else {
-		stop_threaded_test(info);
-		dmatest_run =3D false;
-	}
-	mutex_unlock(&info->lock);
+	if (test_channel[0] !=3D '\0' &&
+	    strcmp(dma_chan_name(chan), test_channel))
+		return false;
=20
-	return param_get_bool(val, kp);
+	return true;
 }
=20
-static int dmatest_run_set(const char *val, const struct kernel_param =
*kp)
+static int __init dmatest_init(void)
 {
-	struct dmatest_info *info =3D &test_info;
-	int ret;
-
-	mutex_lock(&info->lock);
-	ret =3D param_set_bool(val, kp);
-	if (ret) {
-		mutex_unlock(&info->lock);
-		return ret;
-	}
+	struct dmatest_info info;
+	dma_cap_mask_t mask;
=20
-	if (is_threaded_test_run(info))
-		ret =3D -EBUSY;
-	else if (dmatest_run)
-		restart_threaded_test(info, dmatest_run);
+	memset(&info, 0, sizeof(info));
=20
-	mutex_unlock(&info->lock);
+	init_completion(&info.done);
=20
-	return ret;
-}
+	/* Request DMA channel. */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
=20
-static int __init dmatest_init(void)
-{
-	struct dmatest_info *info =3D &test_info;
-	struct dmatest_params *params =3D &info->params;
+	info.chan =3D dma_request_channel(mask, dmatest_filter, NULL);
+	if (!info.chan) {
+		pr_err("Unable to find DMA channel\n");
+		return -ENODEV;
+	}
=20
-	if (dmatest_run) {
-		mutex_lock(&info->lock);
-		run_threaded_test(info);
-		mutex_unlock(&info->lock);
+	if (1 << info.chan->device->copy_align > PAGE_SIZE) {
+		pr_err("%lu-byte buffer too small for %d-byte alignment\n",
+		       PAGE_SIZE, 1 << info.chan->device->copy_align);
+		goto done;
 	}
=20
-	if (params->iterations && wait)
-		wait_event(thread_wait, !is_threaded_test_run(info));
+	/* Run the test. */
+	pr_info("Starting test using %s\n", dma_chan_name(info.chan));
+	dmatest_run(&info);
=20
-	/* module parameters are stable, inittime tests are started,
-	 * let userspace take over 'run' control
-	 */
-	info->did_init =3D true;
+done:
+	dmaengine_terminate_all(info.chan);
+	dma_release_channel(info.chan);
=20
-	return 0;
+	return -ENODEV;
 }
+
 /* when compiled-in wait for drivers to load first */
 late_initcall(dmatest_init);
=20
 static void __exit dmatest_exit(void)
 {
-	struct dmatest_info *info =3D &test_info;
-
-	mutex_lock(&info->lock);
-	stop_threaded_test(info);
-	mutex_unlock(&info->lock);
 }
 module_exit(dmatest_exit);
=20
--=20
Regards,

Laurent Pinchart

