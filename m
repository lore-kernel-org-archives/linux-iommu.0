Return-Path: <SRS0=ZmA0=Y5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C39CC010A2
	for <iommu@archiver.kernel.org>; Tue,  5 Nov 2019 12:17:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467F921D7C
	for <iommu@archiver.kernel.org>; Tue,  5 Nov 2019 12:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="P417idu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467F921D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1F22616E7;
	Tue,  5 Nov 2019 12:17:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1EB0316D1
	for <iommu@lists.linux-foundation.org>;
	Tue,  5 Nov 2019 12:17:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 828178A8
	for <iommu@lists.linux-foundation.org>;
	Tue,  5 Nov 2019 12:17:45 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id j15so437547wrw.5
	for <iommu@lists.linux-foundation.org>;
	Tue, 05 Nov 2019 04:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=5WjUuFi1lzsZ0jYBoaXwxIPUs2nhOsZLPkdWBs2AKLE=;
	b=P417idu8xkSOp83bucE6v/1E1W1RvIuAVTDiRCXs18VWSccTtXfC2aJ4GJu5jds6ZH
	uBJCgJE3ExZ52WKimdaza0yOBUaXRuh7bdWeQ2I3ynlSEB+YpwPjeRqXCVtdrmi8vAap
	DI9GyZy5yMsGuTYmT0V+qqaQFq59NGpnVxLHW1uDAifGPTIJHyV2FFqi0Glf9/WLyDY7
	2AHiPKVrhqw0mqhBfVmq46u5888cPcLrea00kDAAgQ5jy0GlP5wZBchsJhnQ05B7F0gv
	NAnylj9LeqvqQqCHWMLLUu5pOWkckz9FzpzgQEcbufw1DoXqiMfamjxJHFyOPwrLEGub
	4zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=5WjUuFi1lzsZ0jYBoaXwxIPUs2nhOsZLPkdWBs2AKLE=;
	b=j7qAV6PQsM4NqFYzoI08ibew12bKBSJAbDtD49oSlfuBhFQYISrzG2/TVIJ8fj8gYr
	RczZI9Hx8+o/iOd2CBKNLvHhw17IagLi8nmfhfKXZh8tGGTKSLwKsJazNN6habAd0xf4
	5nOdATQVaajE3xeU1Ym30wyj7cgZ2fwc3OiccA1t7QXcZsxxJ6frh0A5H2lbmhEmr3WZ
	xj16GFSwgg5a3jeY40XEvViHNW6yvs6OGZywOXZ3HuccecLvpiLSm47W6V1B5uKVWFLN
	orRlbF/IrMOZ6Zy8vxSmfQikpA7qNk/hu7Kh9zk1CTnkFqMY3HhX5pHvVsX1ZOlUwVMW
	DaXg==
X-Gm-Message-State: APjAAAVOpqhzpp6I7mDy+YZQElviT+dQ4KpPqVlQS0wL2j2/JOKi7RdR
	sFY6EYi5bufJ7xGNBAw36W9DHQ7UO7Q=
X-Google-Smtp-Source: APXvYqwErB67f7DBD+wdgWRB8DG4qf1Fxi2tzJbIRlf8rBiYnT674amq+eMXIK0jGQf3/caWICJLYw==
X-Received: by 2002:adf:f452:: with SMTP id f18mr29422850wrp.264.1572956263645;
	Tue, 05 Nov 2019 04:17:43 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
	by smtp.gmail.com with ESMTPSA id
	b62sm18477866wmc.13.2019.11.05.04.17.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Nov 2019 04:17:43 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Ensure pci transactions coming from PLX NTB are handled
	when  IOMMU is turned on
In-Reply-To: <A3FA9DE1-2EEF-41D8-9AC2-B1F760E7F5D5@arista.com>
Date: Tue, 5 Nov 2019 12:17:42 +0000
Message-Id: <0B8FAD0D-B598-4CEA-A614-67F4C7C5B9CA@arista.com>
References: <A3FA9DE1-2EEF-41D8-9AC2-B1F760E7F5D5@arista.com>
To: iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.102.3)
Cc: linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>
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
From: James Sewart via iommu <iommu@lists.linux-foundation.org>
Reply-To: James Sewart <jamessewart@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Any comments on this?

Cheers,
James.

> On 24 Oct 2019, at 13:52, James Sewart <jamessewart@arista.com> wrote:
> 
> The PLX PEX NTB forwards DMA transactions using Requester ID's that don't exist as
> PCI devices. The devfn for a transaction is used as an index into a lookup table
> storing the origin of a transaction on the other side of the bridge.
> 
> This patch aliases all possible devfn's to the NTB device so that any transaction
> coming in is governed by the mappings for the NTB.
> 
> Signed-Off-By: James Sewart <jamessewart@arista.com>
> ---
> drivers/pci/quirks.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 320255e5e8f8..647f546e427f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5315,6 +5315,28 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
> SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
> SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
> 
> +/*
> + * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. These IDs
> + * are used to forward responses to the originator on the other side of the
> + * NTB. Alias all possible IDs to the NTB to permit access when the IOMMU is
> + * turned on.
> + */
> +static void quirk_PLX_NTB_dma_alias(struct pci_dev *pdev)
> +{
> +	if (!pdev->dma_alias_mask)
> +		pdev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
> +					      sizeof(long), GFP_KERNEL);
> +	if (!pdev->dma_alias_mask) {
> +		dev_warn(&pdev->dev, "Unable to allocate DMA alias mask\n");
> +		return;
> +	}
> +
> +	// PLX NTB may use all 256 devfns
> +	memset(pdev->dma_alias_mask, U8_MAX, (U8_MAX+1)/BITS_PER_BYTE);
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b0, quirk_PLX_NTB_dma_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b1, quirk_PLX_NTB_dma_alias);
> +
> /*
>  * On Lenovo Thinkpad P50 SKUs with a Nvidia Quadro M1000M, the BIOS does
>  * not always reset the secondary Nvidia GPU between reboots if the system
> -- 
> 2.19.1
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
