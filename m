Return-Path: <SRS0=bJ3n=6P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC84C47253
	for <iommu@archiver.kernel.org>; Fri,  1 May 2020 14:44:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13098208D6
	for <iommu@archiver.kernel.org>; Fri,  1 May 2020 14:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SMxlHq5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13098208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D879F87A89;
	Fri,  1 May 2020 14:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yqER61BtXMGl; Fri,  1 May 2020 14:44:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ACD6587A4E;
	Fri,  1 May 2020 14:44:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C3C0C0864;
	Fri,  1 May 2020 14:44:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B37FEC016F
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 14:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9C59A87A89
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 14:44:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H9t0mUE_h0hx for <iommu@lists.linux-foundation.org>;
 Fri,  1 May 2020 14:44:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2BE9387A4E
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 14:44:40 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id x2so1666266pfx.7
 for <iommu@lists.linux-foundation.org>; Fri, 01 May 2020 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=URjoa0IPAuVJrJzf1GzsjjCJgtImSI4fVU++g+IJyuo=;
 b=SMxlHq5r/xlgb1aFLRF6VaIP1+SWFfbYQhAXjYZD4COiPW8KJ+YqJlOeUxHxCY5DlG
 Idx1WYR1HxdMRSDeEA2FIMDrtrlxs+zIzz57nuJsVPdb23kkRR6vDORPdekV6cr8T2ey
 XFPCDrZn+jfp9p8SrvmZa/jauPbMy65QXIIZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=URjoa0IPAuVJrJzf1GzsjjCJgtImSI4fVU++g+IJyuo=;
 b=STBx6Ji7ld5TCj82wkjBABiG71sxTefZoqVZXmk6DlNFdGf4TbyxS3/ShifJA7XE3o
 IBXCM1S5KSgD0Lg5E528ryz4zzX/dLYazKBzY6U1LTEeZ9924G/Tig9qkX6fh9GXVXAl
 ZHq51DhgXtxFOcGiYwxytpPcPH6Y++Qwb06pMqNt9Oo7o0qjAfXqrj8+0L0DqxikDScT
 Z3mWkX82xTFCXrWYiktJgA5rqe1JvL23Utz9dRprm0mDY0sZb500VaUZRGamV/l8chQJ
 xbRhexOpElbGIyhL6BXHenA7agvqs6GkumWi1GuUwKBE7GEMhbYFYp2XbVtGoLrWbQL1
 QxNg==
X-Gm-Message-State: AGi0PubXoV3axEqabSdMRk7CjDFID3dkxc4kyDrp+x3vgLJav4pukfnN
 /GtpOYUiDLGfQ1d7Bdu92Jn6sUNXcoA=
X-Google-Smtp-Source: APiQypLUnTswOhOAFtkg7HBjtcO+qjD0dl/xg8OxDgzzrI8991s9OE6mUk3Jli7DRB2z0sJNg38G+Q==
X-Received: by 2002:a05:6102:409:: with SMTP id
 d9mr3436539vsq.220.1588343964114; 
 Fri, 01 May 2020 07:39:24 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com.
 [209.85.217.49])
 by smtp.gmail.com with ESMTPSA id l11sm848923vkm.20.2020.05.01.07.39.23
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 07:39:23 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id s11so6400976vsq.13
 for <iommu@lists.linux-foundation.org>; Fri, 01 May 2020 07:39:23 -0700 (PDT)
X-Received: by 2002:a67:bd07:: with SMTP id y7mr3484487vsq.109.1588343962687; 
 Fri, 01 May 2020 07:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <1588329036-18732-1-git-send-email-smasetty@codeaurora.org>
In-Reply-To: <1588329036-18732-1-git-send-email-smasetty@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 1 May 2020 07:39:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W+uaPTZHKXq6WYgx-ZDL1QTedEpNw9T747UBD_g1O8CQ@mail.gmail.com>
Message-ID: <CAD=FV=W+uaPTZHKXq6WYgx-ZDL1QTedEpNw9T747UBD_g1O8CQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7180: Add A618 gpu dt blob
To: Sharat Masetty <smasetty@codeaurora.org>
Cc: freedreno <freedreno@lists.freedesktop.org>, Will Deacon <will@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Matthias Kaehlcke <mka@chromium.org>, dri-devel@freedesktop.org,
 Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On Fri, May 1, 2020 at 3:30 AM Sharat Masetty <smasetty@codeaurora.org> wrote:
>
> This patch adds the required dt nodes and properties
> to enabled A618 GPU.
>
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> ---
> * Remove GCC_DDRSS_GPU_AXI_CLK clock reference from gpu smmu node.
>
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 102 +++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)

This is the newer version of the patch:

https://lore.kernel.org/r/1581320465-15854-2-git-send-email-smasetty@codeaurora.org

The change to remove the extra IOMMU clock matches our discussions and
there's no longer anything blocking this from landing.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
