From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=00:14.0
	address=0x000000fdf9103300 flags=0x0600]
Date: Wed, 14 Oct 2015 18:33:38 +0200
Message-ID: <20151014163338.GR27420@8bytes.org>
References: <CADw2B2Mzo2DbMMiyTVjBGVc4-f6Koa6sWQjoLmfX7NZ3B4+saA@mail.gmail.com>
	<20151014090649.GI27420@8bytes.org>
	<CADw2B2MzAMhNX5x9kZ5MN0mAh24ttDu=23EGVLy2aq6Paik4tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADw2B2MzAMhNX5x9kZ5MN0mAh24ttDu=23EGVLy2aq6Paik4tQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "G. Richard Bellamy" <rbellamy-1/AleqyZJC8ybS5Ee8rs3A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2015 at 09:05:05AM -0700, G. Richard Bellamy wrote:
> When I have "iommu=1 iommu=pt amd_iommu_dump=1" on my Kernel command line, the
> messages spam the log so much neither dmesg nor the journal can keep up.

Hmm, the ACPI table looks good, which device(s) are you attaching to the
guest(s)?

Also, can you try if the attached patch changes anything?


Thanks,

	Joerg


--OXfL5xGRrasGEqWY
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="sysmgt-fix.diff"

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f82060e7..6645f2f 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1975,7 +1975,7 @@ static void clear_dte_entry(u16 devid)
 {
 	/* remove entry from the device table seen by the hardware */
 	amd_iommu_dev_table[devid].data[0] = IOMMU_PTE_P | IOMMU_PTE_TV;
-	amd_iommu_dev_table[devid].data[1] = 0;
+	amd_iommu_dev_table[devid].data[1] &= (0x1ffUL << 32);
 
 	amd_iommu_apply_erratum_63(devid);
 }

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--OXfL5xGRrasGEqWY--
