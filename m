From: <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/3] Add larbid init routine for mediatek's gen1 smi larb driver
Date: Fri, 28 Jul 2017 18:55:40 +0800
Message-ID: <1501239343-9190-1-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, xinping.qian-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Mediatek's gen1 smi need the hardware larbid to identify the offset for
the register which controls whether enable iommu for this larb.
In the commit 3c8f4ad85c4b ("memory/mediatek: add support for mt2701"),
the larbid was used without properly initialized. This patchset fixed
that.
This patchset was based on the v2 version of the patch:
memory: mtk-smi: Use of_device_get_match_data helper[1],
which was base on 4.13-rc1

[1] https://patchwork.kernel.org/patch/9864719

Change since v1:
 - Using mtk_smi_larb_gen to identify whether larbid was needed instead of
   checking hard code bindings.

Honghui Zhang (3):
  memory: mtk-smi: add larbid handle routine
  dt-bindings: mediatek: add descriptions for larbid
  arm: dts: mediatek: add larbid property for larb

 .../bindings/memory-controllers/mediatek,smi-larb.txt     | 15 +++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi                             |  3 +++
 drivers/memory/mtk-smi.c                                  | 12 ++++++++++++
 3 files changed, 30 insertions(+)

-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
