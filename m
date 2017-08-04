From: <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 0/4] Add larbid init routine for mediatek's gen1 smi larb
	driver
Date: Fri, 4 Aug 2017 09:32:24 +0800
Message-ID: <1501810348-20997-1-git-send-email-honghui.zhang@mediatek.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, xinping.qian-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Mediatek's gen1 smi need the hardware larb-id to identify the offset for
the register which controls whether enable iommu for this larb.
In the commit 3c8f4ad85c4b ("memory/mediatek: add support for mt2701"),
the larbid was used without properly initialized. This patchset fixed
that.
Also include a patch which using the of_device_get_match_data helper to
simplify the code.
This patchset was base on 4.13-rc1.

Change since v2:
 - Using compatible strings of "mediatek,larb-id" instead of "mediatek,larbid"
   to make it a bit easier to read.
 - Put the v2 of the patch ("memory: mtk-smi: Use of_device_get_match_data helper")[1]
   in this patchset to make the changes easier for review.
 - Add the reivewer's tag in commit messages.

Change since v1:
 - Using mtk_smi_larb_gen to identify whether larbid was needed instead of
   checking hard code bindings.

[1] https://patchwork.kernel.org/patch/9864719

Honghui Zhang (4):
  memory: mtk-smi: Use of_device_get_match_data helper
  memory: mtk-smi: add larbid handle routine
  dt-bindings: mediatek: add descriptions for larbid
  arm: dts: mediatek: add larbid property for larb

 .../memory-controllers/mediatek,smi-larb.txt       | 15 +++++++++++++
 arch/arm/boot/dts/mt2701.dtsi                      |  3 +++
 drivers/memory/mtk-smi.c                           | 26 ++++++++++++----------
 3 files changed, 32 insertions(+), 12 deletions(-)

-- 
2.6.4
