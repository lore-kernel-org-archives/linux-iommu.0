Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.162.73.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436982;
	b=fy7qvbgQx/YLArQCcLwwtZBkLCM6REXMYZTLGK8TRjn859MXdUZVoAUUpEIv6gwPXvWQ
	 ng6T1V6R0Slog5c2sdxJF5t7XMaXHH0Xnmth5q8/DvX2N1tMj174gKXd7zUvElDJ4nkJE
	 GVI7Zyh45/apFq+0hg2yhkcqgWC8A3DmBduO7NBxHSUUnPOdUFOKPcM0EBbRm5673XuZa
	 5B4+9gUHP8F43gJtGenYHCg7lk/5g58ydd1iBrZuErMyR2hqImGjxoMK35bVgsQ/7U5QF
	 NOw0j+4DD7ghwhh6C3SGbjeNVPzv+atAd13FWIiq7GOsUImBcX4FbRr3nY7IQxREX0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436982;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=ROhdZsA4kHTFqPWeKkf2RlJYVEmrs48hwCGYlNZ4YxA=;
	b=aBFUHHTAAersSaj6KI9OSjhRgrV049QAKw9XnFagKZS4JCXiFBQ5PpzdvknJWPxfZJYS
	 ZILy/WFsoJIGttzp3WhvtIRam6y4J1oiO2AzfK0MWok95zQviu5kcRGnmCsaTFm3Nqo6N
	 6NNwlojKkRdQrljkOxXKJ2NMY4y0+FyaAepUGDQ/myYfkIxetVj05+aoEQNqWS3nTKg3I
	 hvlXWVw+eJOLjZlOb3/E/40JJXiWqp9/VozW51PvOSSP9enKaGOcQCTId9KfXF+vdzRVA
	 JMXb2UZYhaR9+b3YvRkR7DDAFXH6R68i1LFbtYtgY2VIT+KnLEayPy0+gVvmmE9fszg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=p6phn3bG;
	arc=none smtp.remote-ip=35.162.73.231
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48705606A883
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 22:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48705606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=p6phn3bG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794436982; x=1825972982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ROhdZsA4kHTFqPWeKkf2RlJYVEmrs48hwCGYlNZ4YxA=;
  b=p6phn3bGokELQQ95qdIxtHYefsSEQ5IuZH/yI8ApsPj4ci4NU216FCjA
   b+5CSJ6Loak8C6F+0cjpPPxXQTuxx0zgW4l9IyDKoXD9Vki5KzAOYkOLb
   I6syb/HkQOq2D2iEy05zi3zdiHmbfjuLfMflTk0r28pSnjeweSaA+g6pL
   GfQ48YeEOesSiw6AUQcixgTNn3pGlLRlCjXxINaELQDXWxk0S8j2rzWAK
   aFNJG5BR3VxVKqCRoG7qaigQwRPCEp+oOAPtH61ZxQ0kWQ082XAcbv02g
   QVvgqIcNmwE5rhUn75Ru/4yi66cnxwaprQadINJoExjisdLzqEn2uf1Uv
   Q==;
X-CSE-ConnectionGUID: jjh+3vwES4W+ihr0Te6OBg==
X-CSE-MsgGUID: Vnjy6dAORNy7UyEtEFCiGA==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33572281"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 22:42:59 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:17653]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id cc5ce1af-39fa-4dc2-a20c-15a0f1464f54; Wed, 11 Nov 2026 22:42:59 +0000 (UTC)
X-Farcaster-Flow-ID: cc5ce1af-39fa-4dc2-a20c-15a0f1464f54
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:42:59 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:42:56 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
CC: The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, <linux-doc@vger.kernel.org>, <iommu@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	<nh-open-source@amazon.com>, <linux-mm@kvack.org>, Jonathan Corbet
	<corbet@lwn.net>
Subject: [PATCH 03/40] nitro_enclaves: Expose CPU pool state under sysfs
Date: Wed, 11 Nov 2026 22:41:48 +0000
Message-ID: <af48ccf36d22c3f61d8afcddadc3f4ae69c0cd1e.1794393490.git.graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1794300002.git.graf@amazon.com>
References: <cover.1794300002.git.graf@amazon.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

When using the dedicated CPU pool, orchestrators need to know whether
there is actually capacity left to spawn a new enclave or sandbox on
a given target NUMA node. The easiest place to expose that is sysfs.

Report the pool under
/sys/devices/virtual/misc/nitro_enclaves/cpu_pool/: total, used and
avail, once as total and once in a nodeN subdirectory per node.
The files are binary attributes, because a CPU list can outgrow the one
page a device attribute gets.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 .../sysfs-devices-virtual-misc-nitro_enclaves |  75 ++++
 MAINTAINERS                                   |   1 +
 drivers/virt/nitro_enclaves/ne_misc_dev.c     | 388 +++++++++++++++++-
 drivers/virt/nitro_enclaves/ne_misc_dev.h     |   3 +
 drivers/virt/nitro_enclaves/ne_pci_dev.c      |  16 +
 5 files changed, 469 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-virtual-misc-nitro_enclaves

diff --git a/Documentation/ABI/testing/sysfs-devices-virtual-misc-nitro_enclaves b/Documentation/ABI/testing/sysfs-devices-virtual-misc-nitro_enclaves
new file mode 100644
index 0000000000000..596054b75e0cf
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-virtual-misc-nitro_enclaves
@@ -0,0 +1,75 @@
+What:		/sys/devices/virtual/misc/nitro_enclaves/cpu_pool/total
+What:		/sys/devices/virtual/misc/nitro_enclaves/cpu_pool/used
+What:		/sys/devices/virtual/misc/nitro_enclaves/cpu_pool/avail
+Date:		November 2026
+KernelVersion:	7.5
+Contact:	aws-nitro-enclaves-devel@amazon.com
+Description:
+		Read-only. CPU-list strings describing the Nitro Enclaves CPU
+		pool. The pool is handed out a whole core at a time, so these
+		files name threads but move in units of a core:
+
+		total
+			every CPU thread dedicated to the pool
+
+		used
+			every thread of every core an enclave holds, including
+			the ones it has not made vCPUs of yet
+
+		avail
+			every thread of every core no enclave holds, so the set
+			a new enclave can draw from
+
+		A thread leaves used when the enclave holding it is freed.
+		A release that fails part way through keeps the thread in
+		used. total changes when the pool is reconfigured, which
+		requires that no enclave exists.
+
+		A read longer than one page is served in parts, and each part
+		renders the pool as it stands when that part is read. A thread
+		that changes hands during such a read can be missing from every
+		part, and the parts joined together can fail to parse as a CPU
+		list at all - see the warning in the kerneldoc of
+		bitmap_print_bitmask_to_buf() in lib/bitmap-str.c, which
+		bitmap_print_list_to_buf() refers to.
+
+		NE_ADD_VCPU auto-pick and NE_ADD_ANY_VCPU each look for a free
+		thread of a core the enclave already holds before taking a
+		core out of avail, so the thread either returns can be one
+		avail does not list.
+
+		A read takes the pool lock, so it can wait for a write to
+		ne_cpus to finish.
+
+What:		/sys/devices/virtual/misc/nitro_enclaves/cpu_pool/nodeX/total
+What:		/sys/devices/virtual/misc/nitro_enclaves/cpu_pool/nodeX/used
+What:		/sys/devices/virtual/misc/nitro_enclaves/cpu_pool/nodeX/avail
+Date:		November 2026
+KernelVersion:	7.5
+Contact:	aws-nitro-enclaves-devel@amazon.com
+Description:
+		Read-only. The cpu_pool files of the same name, over the
+		threads of NUMA node X alone. There is a nodeX directory for
+		each node that was online when the device was probed, and its
+		files read empty for a node the pool holds no thread of.
+
+		A thread appears under exactly one node, the one its core was
+		on while that core was still online. The driver offlines the
+		threads it takes into the pool, so
+		/sys/devices/system/node/nodeX/cpulist stops listing them and
+		is not what these files are cut from.
+
+		nodeX/used and nodeX/avail are cut out of nodeX/total the way
+		used and avail are cut out of total, so a node file and its
+		pool-wide counterpart cannot disagree, and the nodeX/total of
+		every node join to total.
+
+		NE_ADD_ANY_VCPU takes a core from the node it names, so
+		nodeX/avail is what a request for that node can draw on. What
+		is written above about a read longer than one page, and about
+		the free thread of a held core that avail does not list,
+		holds for these files as well.
+
+		The directories appear once the device has been probed and the
+		misc device registered, so a reader that opens the misc device
+		the moment it appears can find cpu_pool empty.
diff --git a/MAINTAINERS b/MAINTAINERS
index 20e4a56a197ee..f946a79b34d0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19839,6 +19839,7 @@ R:	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 W:	https://aws.amazon.com/ec2/nitro/nitro-enclaves/
+F:	Documentation/ABI/testing/sysfs-devices-virtual-misc-nitro_enclaves
 F:	Documentation/virt/ne_overview.rst
 F:	drivers/virt/nitro_enclaves/
 F:	include/linux/nitro_enclaves.h
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index 576f1909c7304..66bcaec8d3199 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -12,11 +12,14 @@
 #include <linux/build_bug.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
+#include <linux/cpumask.h>
 #include <linux/device.h>
 #include <linux/file.h>
 #include <linux/hugetlb.h>
 #include <linux/ioctl.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/kstrtox.h>
 #include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
@@ -33,6 +36,8 @@
 #include <linux/range.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/vm_sockets.h>
@@ -95,18 +100,6 @@ static const struct file_operations ne_fops = {
 	.compat_ioctl	= compat_ptr_ioctl,
 };
 
-static struct miscdevice ne_misc_dev = {
-	.minor	= MISC_DYNAMIC_MINOR,
-	.name	= "nitro_enclaves",
-	.fops	= &ne_fops,
-	.mode	= 0660,
-};
-
-struct ne_devs ne_devs = {
-	.ne_misc_dev	= &ne_misc_dev,
-	.lock		= __RWSEM_INITIALIZER(ne_devs.lock),
-};
-
 /*
  * TODO: Update logic to create new sysfs entries instead of using
  * a kernel parameter e.g. if multiple sysfs files needed.
@@ -163,6 +156,19 @@ static const struct kernel_param *ne_cpus_kp;
  *				ne_setup_cpu_pool() offlines them, because
  *				cpu_to_node() is not documented to answer for an
  *				offline CPU.
+ * @node_cpus:			The threads of the pool on each NUMA node, indexed
+ *				by node id and sized by nr_node_ids. It partitions
+ *				@total_cpus: a thread sits in the entry of the node
+ *				its core was on while that core was still online,
+ *				which is the node @core_nid records for the same
+ *				core. NULL if no pool is set up.
+ * @total_cpus:			Every CPU thread in the pool, as parsed from
+ *				ne_cpus. Empty if no pool is set up.
+ * @used_cpus:			The subset of @total_cpus that enclaves hold.
+ *				A whole core enters when an enclave takes it
+ *				and leaves when the enclave is freed, in
+ *				the same two places that move the core out of
+ *				and back into @avail_threads_per_core.
  */
 struct ne_cpu_pool {
 	cpumask_var_t	*avail_threads_per_core;
@@ -170,12 +176,330 @@ struct ne_cpu_pool {
 	unsigned int	nr_parent_vm_cores;
 	int		numa_node;
 	int		*core_nid;
+	cpumask_var_t	*node_cpus;
+	struct cpumask	total_cpus;
+	struct cpumask	used_cpus;
 };
 
 static struct ne_cpu_pool ne_cpu_pool = {
 	.mutex = __MUTEX_INITIALIZER(ne_cpu_pool.mutex),
 };
 
+/*
+ * cpu_pool/ sysfs group on the Nitro Enclaves misc device: report the CPU
+ * pool occupancy.
+ *
+ *   /sys/devices/virtual/misc/nitro_enclaves/cpu_pool/{total,used,avail}
+ *
+ * The three files are CPU-list strings rendered from the pool masks under the
+ * pool mutex. avail is what is left of total once used is taken out of it, so
+ * a read has nothing to work out that the allocator has not already decided.
+ * They are binary attributes sized the way the per-node CPU lists under
+ * /sys/devices/system/node are, because a CPU list naming every thread of a
+ * large pool does not fit in the single page a device attribute is handed.
+ */
+
+static ssize_t total_read(struct file *file, struct kobject *kobj,
+			  const struct bin_attribute *attr, char *buf,
+			  loff_t off, size_t count)
+{
+	ssize_t n;
+
+	mutex_lock(&ne_cpu_pool.mutex);
+	n = cpumap_print_list_to_buf(buf, &ne_cpu_pool.total_cpus, off, count);
+	mutex_unlock(&ne_cpu_pool.mutex);
+
+	return n;
+}
+
+static const BIN_ATTR_RO(total, CPULIST_FILE_MAX_BYTES);
+
+static ssize_t used_read(struct file *file, struct kobject *kobj,
+			 const struct bin_attribute *attr, char *buf,
+			 loff_t off, size_t count)
+{
+	ssize_t n;
+
+	mutex_lock(&ne_cpu_pool.mutex);
+	n = cpumap_print_list_to_buf(buf, &ne_cpu_pool.used_cpus, off, count);
+	mutex_unlock(&ne_cpu_pool.mutex);
+
+	return n;
+}
+
+static const BIN_ATTR_RO(used, CPULIST_FILE_MAX_BYTES);
+
+static ssize_t avail_read(struct file *file, struct kobject *kobj,
+			  const struct bin_attribute *attr, char *buf,
+			  loff_t off, size_t count)
+{
+	cpumask_var_t avail;
+	ssize_t n;
+
+	if (!alloc_cpumask_var(&avail, GFP_KERNEL))
+		return -ENOMEM;
+
+	mutex_lock(&ne_cpu_pool.mutex);
+	cpumask_andnot(avail, &ne_cpu_pool.total_cpus, &ne_cpu_pool.used_cpus);
+	mutex_unlock(&ne_cpu_pool.mutex);
+
+	n = cpumap_print_list_to_buf(buf, avail, off, count);
+
+	free_cpumask_var(avail);
+
+	return n;
+}
+
+static const BIN_ATTR_RO(avail, CPULIST_FILE_MAX_BYTES);
+
+static const struct bin_attribute *const ne_cpu_pool_bin_attrs[] = {
+	&bin_attr_total,
+	&bin_attr_used,
+	&bin_attr_avail,
+	NULL,
+};
+
+static const struct attribute_group ne_cpu_pool_group = {
+	.bin_attrs	= ne_cpu_pool_bin_attrs,
+};
+
+/*
+ * cpu_pool/nodeX/ sysfs groups on the Nitro Enclaves misc device: the three
+ * files above, over the threads of one NUMA node.
+ *
+ *   /sys/devices/virtual/misc/nitro_enclaves/cpu_pool/nodeX/{total,used,avail}
+ *
+ * One directory per node that was online when the device was probed, each
+ * holding the same three attributes. The node id is in the directory's name
+ * and is read back out of it, so the three attributes are shared rather than
+ * made per node. A node the pool holds nothing on reads empty in all three.
+ */
+
+/**
+ * enum ne_cpu_pool_view - Which view of a node's pool threads to render.
+ * @NE_CPU_POOL_TOTAL:	Every pool thread of the node.
+ * @NE_CPU_POOL_USED:	The ones enclaves hold.
+ * @NE_CPU_POOL_AVAIL:	The rest.
+ */
+enum ne_cpu_pool_view {
+	NE_CPU_POOL_TOTAL,
+	NE_CPU_POOL_USED,
+	NE_CPU_POOL_AVAIL,
+};
+
+/**
+ * ne_cpu_pool_node_read() - Render one view of one node's pool threads.
+ * @kobj:	The nodeX directory the read came through.
+ * @view:	Which of the three views to render.
+ * @buf:	Buffer to render the CPU list into.
+ * @off:	Offset into the CPU list to render from.
+ * @count:	Bytes of the CPU list to render.
+ *
+ * The node's threads come from the partition of the pool recorded while the
+ * pool's CPUs were online, so this answers for CPUs the driver has offlined.
+ *
+ * Context: Process context.
+ * Return:
+ * * Number of bytes rendered.
+ * * Negative return value on failure.
+ */
+static ssize_t ne_cpu_pool_node_read(struct kobject *kobj,
+				     enum ne_cpu_pool_view view, char *buf,
+				     loff_t off, size_t count)
+{
+	cpumask_var_t threads;
+	ssize_t n;
+	int nid = 0;
+
+	if (kstrtoint(kobject_name(kobj) + strlen("node"), 10, &nid))
+		return -EINVAL;
+
+	if (nid < 0 || (unsigned int)nid >= nr_node_ids)
+		return -EINVAL;
+
+	if (!alloc_cpumask_var(&threads, GFP_KERNEL))
+		return -ENOMEM;
+
+	mutex_lock(&ne_cpu_pool.mutex);
+
+	if (!ne_cpu_pool.node_cpus) {
+		cpumask_clear(threads);
+	} else {
+		cpumask_copy(threads, ne_cpu_pool.node_cpus[nid]);
+
+		if (view == NE_CPU_POOL_USED)
+			cpumask_and(threads, threads, &ne_cpu_pool.used_cpus);
+		else if (view == NE_CPU_POOL_AVAIL)
+			cpumask_andnot(threads, threads,
+				       &ne_cpu_pool.used_cpus);
+	}
+
+	mutex_unlock(&ne_cpu_pool.mutex);
+
+	n = cpumap_print_list_to_buf(buf, threads, off, count);
+
+	free_cpumask_var(threads);
+
+	return n;
+}
+
+static ssize_t node_total_read(struct file *file, struct kobject *kobj,
+			       const struct bin_attribute *attr, char *buf,
+			       loff_t off, size_t count)
+{
+	return ne_cpu_pool_node_read(kobj, NE_CPU_POOL_TOTAL, buf, off, count);
+}
+
+static const struct bin_attribute bin_attr_node_total =
+	__BIN_ATTR(total, 0444, node_total_read, NULL, CPULIST_FILE_MAX_BYTES);
+
+static ssize_t node_used_read(struct file *file, struct kobject *kobj,
+			      const struct bin_attribute *attr, char *buf,
+			      loff_t off, size_t count)
+{
+	return ne_cpu_pool_node_read(kobj, NE_CPU_POOL_USED, buf, off, count);
+}
+
+static const struct bin_attribute bin_attr_node_used =
+	__BIN_ATTR(used, 0444, node_used_read, NULL, CPULIST_FILE_MAX_BYTES);
+
+static ssize_t node_avail_read(struct file *file, struct kobject *kobj,
+			       const struct bin_attribute *attr, char *buf,
+			       loff_t off, size_t count)
+{
+	return ne_cpu_pool_node_read(kobj, NE_CPU_POOL_AVAIL, buf, off, count);
+}
+
+static const struct bin_attribute bin_attr_node_avail =
+	__BIN_ATTR(avail, 0444, node_avail_read, NULL, CPULIST_FILE_MAX_BYTES);
+
+static const struct bin_attribute *const ne_cpu_pool_node_bin_attrs[] = {
+	&bin_attr_node_total,
+	&bin_attr_node_used,
+	&bin_attr_node_avail,
+	NULL,
+};
+
+static const struct attribute_group ne_cpu_pool_node_group = {
+	.bin_attrs	= ne_cpu_pool_node_bin_attrs,
+};
+
+static struct kobject *ne_cpu_pool_kobj;
+static struct kobject **ne_cpu_pool_node_kobj;
+
+static struct miscdevice ne_misc_dev = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "nitro_enclaves",
+	.fops	= &ne_fops,
+	.mode	= 0660,
+};
+
+struct ne_devs ne_devs = {
+	.ne_misc_dev	= &ne_misc_dev,
+	.lock		= __RWSEM_INITIALIZER(ne_devs.lock),
+};
+
+/**
+ * ne_cpu_pool_sysfs_exit() - Take down the cpu_pool sysfs tree.
+ * @void:	No parameters provided.
+ *
+ * Idempotent, so the setup path can call it on a tree it built part of.
+ *
+ * Context: Process context.
+ */
+void ne_cpu_pool_sysfs_exit(void)
+{
+	unsigned int nid = 0;
+
+	if (ne_cpu_pool_node_kobj) {
+		for (nid = 0; nid < nr_node_ids; nid++) {
+			if (!ne_cpu_pool_node_kobj[nid])
+				continue;
+
+			sysfs_remove_group(ne_cpu_pool_node_kobj[nid],
+					   &ne_cpu_pool_node_group);
+			kobject_put(ne_cpu_pool_node_kobj[nid]);
+			ne_cpu_pool_node_kobj[nid] = NULL;
+		}
+
+		kfree(ne_cpu_pool_node_kobj);
+		ne_cpu_pool_node_kobj = NULL;
+	}
+
+	if (ne_cpu_pool_kobj) {
+		sysfs_remove_group(ne_cpu_pool_kobj, &ne_cpu_pool_group);
+		kobject_put(ne_cpu_pool_kobj);
+		ne_cpu_pool_kobj = NULL;
+	}
+}
+
+/**
+ * ne_cpu_pool_sysfs_init() - Build the cpu_pool sysfs tree.
+ * @void:	No parameters provided.
+ *
+ * The pool-wide files hang on a kobject of their own rather than on a named
+ * attribute group of the misc device, because the per-node directories are
+ * kobjects and a kobject takes a kobject as its parent. So this runs once the
+ * misc device is registered and its kobject exists.
+ *
+ * A directory is made for each node that is online now. A node that comes
+ * online later has no directory, and the pool cannot take a thread of it
+ * either: ne_setup_cpu_pool() refuses a CPU that is offline.
+ *
+ * Context: Process context.
+ * Return:
+ * * 0 on success.
+ * * Negative return value on failure.
+ */
+int ne_cpu_pool_sysfs_init(void)
+{
+	unsigned int nid = 0;
+	int rc = -ENOMEM;
+
+	ne_cpu_pool_kobj = kobject_create_and_add("cpu_pool",
+						  &ne_misc_dev.this_device->kobj);
+	if (!ne_cpu_pool_kobj)
+		return -ENOMEM;
+
+	rc = sysfs_create_group(ne_cpu_pool_kobj, &ne_cpu_pool_group);
+	if (rc < 0)
+		goto sysfs_exit;
+
+	ne_cpu_pool_node_kobj = kzalloc_objs(*ne_cpu_pool_node_kobj,
+					     nr_node_ids);
+	if (!ne_cpu_pool_node_kobj) {
+		rc = -ENOMEM;
+
+		goto sysfs_exit;
+	}
+
+	for_each_online_node(nid) {
+		char name[16];
+
+		snprintf(name, sizeof(name), "node%u", nid);
+
+		ne_cpu_pool_node_kobj[nid] =
+			kobject_create_and_add(name, ne_cpu_pool_kobj);
+		if (!ne_cpu_pool_node_kobj[nid]) {
+			rc = -ENOMEM;
+
+			goto sysfs_exit;
+		}
+
+		rc = sysfs_create_group(ne_cpu_pool_node_kobj[nid],
+					&ne_cpu_pool_node_group);
+		if (rc < 0)
+			goto sysfs_exit;
+	}
+
+	return 0;
+
+sysfs_exit:
+	ne_cpu_pool_sysfs_exit();
+
+	return rc;
+}
+
 /**
  * struct ne_phys_contig_mem_regions - Contiguous physical memory regions.
  * @num:	The number of regions that currently has.
@@ -196,6 +520,7 @@ struct ne_phys_contig_mem_regions {
 static void ne_free_core_slots(void)
 {
 	unsigned int i = 0;
+	unsigned int nid = 0;
 
 	if (ne_cpu_pool.avail_threads_per_core) {
 		for (i = 0; i < ne_cpu_pool.nr_parent_vm_cores; i++)
@@ -207,6 +532,14 @@ static void ne_free_core_slots(void)
 
 	kfree(ne_cpu_pool.core_nid);
 	ne_cpu_pool.core_nid = NULL;
+
+	if (ne_cpu_pool.node_cpus) {
+		for (nid = 0; nid < nr_node_ids; nid++)
+			free_cpumask_var(ne_cpu_pool.node_cpus[nid]);
+
+		kfree(ne_cpu_pool.node_cpus);
+		ne_cpu_pool.node_cpus = NULL;
+	}
 }
 
 /**
@@ -234,8 +567,10 @@ static int ne_build_core_slots(const struct cpumask *cpu_pool)
 	unsigned int cpu_sibling = 0;
 	unsigned int i = 0;
 	unsigned int next_core_idx = 0;
+	unsigned int nid = 0;
 	unsigned int nr_cores = 0;
 	cpumask_var_t processed;
+	int core_nid = 0;
 	int rc = -ENOMEM;
 
 	if (!zalloc_cpumask_var(&processed, GFP_KERNEL))
@@ -261,6 +596,14 @@ static int ne_build_core_slots(const struct cpumask *cpu_pool)
 	if (!ne_cpu_pool.core_nid)
 		goto free_slots;
 
+	ne_cpu_pool.node_cpus = kzalloc_objs(*ne_cpu_pool.node_cpus, nr_node_ids);
+	if (!ne_cpu_pool.node_cpus)
+		goto free_slots;
+
+	for (nid = 0; nid < nr_node_ids; nid++)
+		if (!zalloc_cpumask_var(&ne_cpu_pool.node_cpus[nid], GFP_KERNEL))
+			goto free_slots;
+
 	for (i = 0; i < nr_cores; i++)
 		if (!zalloc_cpumask_var(&ne_cpu_pool.avail_threads_per_core[i], GFP_KERNEL))
 			goto free_slots;
@@ -280,7 +623,12 @@ static int ne_build_core_slots(const struct cpumask *cpu_pool)
 			cpumask_set_cpu(cpu_sibling, processed);
 		}
 
-		ne_cpu_pool.core_nid[next_core_idx] = cpu_to_node(cpu);
+		core_nid = cpu_to_node(cpu);
+
+		ne_cpu_pool.core_nid[next_core_idx] = core_nid;
+		cpumask_or(ne_cpu_pool.node_cpus[core_nid],
+			   ne_cpu_pool.node_cpus[core_nid],
+			   ne_cpu_pool.avail_threads_per_core[next_core_idx]);
 
 		next_core_idx++;
 	}
@@ -452,6 +800,9 @@ static int ne_setup_cpu_pool(const struct cpumask *cpu_pool)
 		}
 	}
 
+	cpumask_copy(&ne_cpu_pool.total_cpus, cpu_pool);
+	cpumask_clear(&ne_cpu_pool.used_cpus);
+
 	ne_cpu_pool.numa_node = numa_node;
 
 	mutex_unlock(&ne_cpu_pool.mutex);
@@ -466,6 +817,8 @@ static int ne_setup_cpu_pool(const struct cpumask *cpu_pool)
 unlock_hotplug:
 	cpus_read_unlock();
 reset_pool:
+	cpumask_clear(&ne_cpu_pool.total_cpus);
+	cpumask_clear(&ne_cpu_pool.used_cpus);
 	ne_cpu_pool.nr_parent_vm_cores = 0;
 	ne_cpu_pool.numa_node = NUMA_NO_NODE;
 	mutex_unlock(&ne_cpu_pool.mutex);
@@ -504,6 +857,8 @@ static void ne_teardown_cpu_pool(void)
 		}
 
 	ne_free_core_slots();
+	cpumask_clear(&ne_cpu_pool.total_cpus);
+	cpumask_clear(&ne_cpu_pool.used_cpus);
 	ne_cpu_pool.nr_parent_vm_cores = 0;
 	ne_cpu_pool.numa_node = NUMA_NO_NODE;
 
@@ -758,6 +1113,9 @@ static int ne_set_enclave_threads_per_core(struct ne_enclave *ne_enclave,
 	for_each_cpu(cpu, ne_cpu_pool.avail_threads_per_core[core_id])
 		cpumask_set_cpu(cpu, ne_enclave->threads_per_core[core_id]);
 
+	cpumask_or(&ne_cpu_pool.used_cpus, &ne_cpu_pool.used_cpus,
+		   ne_cpu_pool.avail_threads_per_core[core_id]);
+
 	cpumask_clear(ne_cpu_pool.avail_threads_per_core[core_id]);
 
 	return 0;
@@ -1768,9 +2126,11 @@ static void ne_enclave_remove_all_vcpu_id_entries(struct ne_enclave *ne_enclave)
 		       ne_cpu_pool.nr_parent_vm_cores);
 
 	for (i = 0; i < nr_cores; i++)
-		for_each_cpu(cpu, ne_enclave->threads_per_core[i])
+		for_each_cpu(cpu, ne_enclave->threads_per_core[i]) {
 			/* Update the available NE CPU pool. */
 			cpumask_set_cpu(cpu, ne_cpu_pool.avail_threads_per_core[i]);
+			cpumask_clear_cpu(cpu, &ne_cpu_pool.used_cpus);
+		}
 
 	for (i = 0; i < ne_enclave->nr_parent_vm_cores; i++)
 		free_cpumask_var(ne_enclave->threads_per_core[i]);
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.h b/drivers/virt/nitro_enclaves/ne_misc_dev.h
index 23a783bab3d2f..483037061eafe 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.h
@@ -115,4 +115,7 @@ struct ne_devs {
 /* Nitro Enclaves (NE) data structure for keeping refs to the NE misc and PCI devices. */
 extern struct ne_devs ne_devs;
 
+int ne_cpu_pool_sysfs_init(void);
+void ne_cpu_pool_sysfs_exit(void);
+
 #endif /* _NE_MISC_DEV_H_ */
diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.c b/drivers/virt/nitro_enclaves/ne_pci_dev.c
index edc72d4f623e5..2d44cae4ac0cf 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.c
@@ -695,8 +695,20 @@ static int ne_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	up_write(&ne_devs.lock);
 
+	rc = ne_cpu_pool_sysfs_init();
+	if (rc < 0) {
+		dev_err(&pdev->dev, "Error in cpu pool sysfs init [rc=%d]\n",
+			rc);
+
+		goto deregister_misc_dev;
+	}
+
 	return 0;
 
+deregister_misc_dev:
+	down_write(&ne_devs.lock);
+	ne_pci_dev_detach_enclaves(ne_pci_dev);
+	misc_deregister(ne_devs.ne_misc_dev);
 disable_ne_pci_dev:
 	ne_devs.ne_pci_dev = NULL;
 unlock_ne_devs:
@@ -727,6 +739,8 @@ static void ne_pci_remove(struct pci_dev *pdev)
 {
 	struct ne_pci_dev *ne_pci_dev = pci_get_drvdata(pdev);
 
+	ne_cpu_pool_sysfs_exit();
+
 	down_write(&ne_devs.lock);
 
 	ne_pci_dev_detach_enclaves(ne_pci_dev);
@@ -765,6 +779,8 @@ static void ne_pci_shutdown(struct pci_dev *pdev)
 	if (!ne_pci_dev)
 		return;
 
+	ne_cpu_pool_sysfs_exit();
+
 	down_write(&ne_devs.lock);
 
 	ne_pci_dev_detach_enclaves(ne_pci_dev);
-- 
2.47.1

