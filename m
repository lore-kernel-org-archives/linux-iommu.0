Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042C7C4360C
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 20:06:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35C321A4A
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 20:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuUMwz7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35C321A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 92114CBA;
	Thu, 26 Sep 2019 20:06:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 755B4CAB
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 20:06:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B52EF8B8
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 20:06:15 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id v38so362083edm.7
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 13:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=L4g0OlMIEPfSG1EvFtoZmVR71TkVEEjE9tngR9VbY+k=;
	b=cuUMwz7llVDA8xBOBlRlV9PxtH15BdZEWv9Ktgr0mAHsTACitBgTbXylS7HVATC4aE
	CP4Hsn2Rzv+M3MBiNSR4VZOjGYSg1FscXnXgo9GuWDVe8Eytr3WegLqfl/oxvBNbqau9
	HAow9zC8sGqu1fNLs1omYthATkkRzFMQJqWMhunTCiL901WTWMXem1pjECwNuyc3fDC9
	BXyKoM7bVIZDTXAJdwMwpcSqSD12lndF9nX9hbPkGUDeMwBDiWey0fYtHkZlYw6gE3FL
	KVUTQdOez+lut8+NhPXXHW/nZx8UFyhRcRcHtU/d1hnTMjc1zwuqIQ/pB4FE1InG4jmr
	I5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=L4g0OlMIEPfSG1EvFtoZmVR71TkVEEjE9tngR9VbY+k=;
	b=o8UPYEnfQxHTh+VpbhEtNzda7o5ftnhwowosw4S/dZG8ClLSVnvi/tIF07uQ1HgPEr
	+gS5V2Wj52vexap59a6uwoY41vtbmwEREpc1ANUiQRJ8BJMQ0t66QcTFflE8Jyq8nGmc
	BmDDQWe8uH9/JILCmvfm7b+C+ZjA91brT7Z6DIfoX9DIxBU8xwigsdwH2Hp1OWdQEl6R
	PRk/17n0OXtHGrapYdMNj1oUSZJ9yU2fyympZ8HIv7oYnz1lTyhTB/tzqxhaBXYiVZF1
	v4/kA0GeNlTT8E0lrb8RlcuuvoCalWuHlQo6vVzO5pcb7WvSPbp4UCPpoNlcJSegHUFb
	wuWQ==
X-Gm-Message-State: APjAAAWm9D/Szt6paTdcUzvZcRY7L6r2cgSnL5IedqtZD/hgdffwqchT
	lAg2ofbcbeawgQelvZhWyedJmQw0Qy9mpndl3KY=
X-Google-Smtp-Source: APXvYqxD7haHkKiWJOBTMNuhd/IDHgpHF/JGgC0pHOi/KcXpvT1c5VHC+8mXNwGpu+dTYGEABlcCXblggdbo2JLewwc=
X-Received: by 2002:a17:906:4c4c:: with SMTP id
	d12mr4817068ejw.174.1569528374345; 
	Thu, 26 Sep 2019 13:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190926120516.4981-1-kholk11@gmail.com>
	<20190926120516.4981-2-kholk11@gmail.com>
In-Reply-To: <20190926120516.4981-2-kholk11@gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 26 Sep 2019 13:06:03 -0700
Message-ID: <CAF6AEGs-+SGEJYA4FgGcMXVghLoXmDWbBMjS_BHm=7+9FfYv5g@mail.gmail.com>
Subject: Re: [PATCH 1/6] iommu/qcom: Use the asid read from device-tree if
	specified
To: AngeloGioacchino Del Regno <kholk11@gmail.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, marijns95@gmail.com,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Andy Gross <agross@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, Sep 26, 2019 at 5:05 AM <kholk11@gmail.com> wrote:
>
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
>
> As specified in this driver, the context banks are 0x1000 apart.
> Problem is that sometimes the context number (our asid) does not
> match this logic and we end up using the wrong one: this starts
> being a problem in the case that we need to send TZ commands
> to do anything on a specific context.
>
> For this reason, read the ASID from the DT if the property
> "qcom,ctx-num" is present on the IOMMU context node.
>
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>  .../devicetree/bindings/iommu/qcom,iommu.txt    |  1 +
>  drivers/iommu/qcom_iommu.c                      | 17 ++++++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> index 059139abce35..98102b323196 100644
> --- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> @@ -38,6 +38,7 @@ to non-secure vs secure interrupt line.
>          - "qcom,msm-iommu-v1-sec" : secure context bank
>    - reg            : Base address and size of context bank within the iommu
>    - interrupts     : The context fault irq.
> +  - qcom,ctx-num   : The number associated to the context bank


I guess this should be more like:

+  and the following optional properties:
+  - qcom,ctx-num   : The number associated to the context bank

(since this is an optional property)

BR,
-R

>
>  ** Optional properties:
>
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index dadc707573a2..5837556af147 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -557,7 +557,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>          * index into qcom_iommu->ctxs:
>          */
>         if (WARN_ON(asid < 1) ||
> -           WARN_ON(asid > qcom_iommu->num_ctxs))
> +           WARN_ON(asid > qcom_iommu->num_ctxs) ||
> +           WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL))
>                 return -EINVAL;
>
>         if (!fwspec->iommu_priv) {
> @@ -665,7 +666,8 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
>
>  static int get_asid(const struct device_node *np)
>  {
> -       u32 reg;
> +       u32 reg, val;
> +       int asid;
>
>         /* read the "reg" property directly to get the relative address
>          * of the context bank, and calculate the asid from that:
> @@ -673,7 +675,16 @@ static int get_asid(const struct device_node *np)
>         if (of_property_read_u32_index(np, "reg", 0, &reg))
>                 return -ENODEV;
>
> -       return reg / 0x1000;      /* context banks are 0x1000 apart */
> +       /* Context banks are 0x1000 apart but, in some cases, the ASID
> +        * number doesn't match to this logic and needs to be passed
> +        * from the DT configuration explicitly.
> +        */
> +       if (of_property_read_u32(np, "qcom,ctx-num", &val))
> +               asid = reg / 0x1000;
> +       else
> +               asid = val;
> +
> +       return asid;
>  }
>
>  static int qcom_iommu_ctx_probe(struct platform_device *pdev)
> --
> 2.21.0
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
