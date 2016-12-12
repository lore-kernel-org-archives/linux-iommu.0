From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] iommu/amd: fix the left value check of cmd buffer
Date: Mon, 12 Dec 2016 07:28:26 -0500
Message-ID: <1481545706-1610-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The generic command buffer entry is 128 bits (16 bytes), so the offset
of tail and head pointer should be 16 bytes aligned and increased with
0x10 per command.

When cmd buf is full, head = (tail + 0x10) % CMD_BUFFER_SIZE.

So when left space of cmd buf should be able to store only two
command, we should be issued one COMPLETE_WAIT additionally to wait
all older commands completed. Then the left space should be increased
after IOMMU fetching from cmd buf.

So left check value should be left <= 0x20 (two commands).

Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
---

Hi Joerg,

The command entry is 128 bits (16 bytes aligned), so the left value
shouldn't be 2. I think here, you might check the case when the buf is
full, so modify the value as the two commands left. Please review.

Thanks,
Rui

---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 019e027..3ef0f42 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1023,7 +1023,7 @@ static int __iommu_queue_command_sync(struct amd_iommu *iommu,
 	next_tail = (tail + sizeof(*cmd)) % CMD_BUFFER_SIZE;
 	left      = (head - next_tail) % CMD_BUFFER_SIZE;
 
-	if (left <= 2) {
+	if (left <= 0x20) {
 		struct iommu_cmd sync_cmd;
 		int ret;
 
-- 
2.1.0
