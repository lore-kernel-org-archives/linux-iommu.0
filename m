Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D37C33C99
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 07:16:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496132073A
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 07:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w/heI5Ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496132073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2642288418;
	Fri, 10 Jan 2020 07:16:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9qyADo4INzUH; Fri, 10 Jan 2020 07:15:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B57A788341;
	Fri, 10 Jan 2020 07:15:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E9D8C1D7D;
	Fri, 10 Jan 2020 07:15:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 443E1C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 07:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3DFDA86F87
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 07:15:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2QfJ8blBvxie for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 07:15:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 06FA186DEB
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 07:15:57 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id w15so744639wru.4
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jan 2020 23:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9OKjM0NiA29A1YJnbOkfMLLtP+OMdLBmVsUr4YFKYmI=;
 b=w/heI5CiX5CG06QP7Sv0cxrLLmnMMNh5cvAR7T4TCmnIz8Eg3fbiQMZwB2YUCUpzbx
 mmUosVo3fH6aOf6Aw9xKPmPZaT8+jdHft0aUNvd2tlXM5ANa9UjfFpFSb57+ymTYjG/2
 pmxgcgaIyHPJWXiJr293yDtYme/mtd7L/Ak/YuEKAWw/I7xuaRqZVe1bFAEd9cpRytTN
 8ysCaE+HPdU//NOzq5Yzx8gqKE6Qa7hl0Pjp7FgaKVgfeZQOTmnyBEh7OOHhgjv7kBn9
 PyVyqewx7EOuO4LrYCozQosfklyZ3gAuvuPuSG21SND9Z7ck4iaNLeZ0n3+gj/x48gi1
 MOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9OKjM0NiA29A1YJnbOkfMLLtP+OMdLBmVsUr4YFKYmI=;
 b=nv+uwcGJ50zageEUsXIOWq83zcLr714MTkNzBJOoHE/59L5JgpMlcX8MVB+ezvK4Xv
 B23FlGGpozZkKqeBCqX3sp0uG6toFi57R01p4vhrydixASGEJzFtNmM61nGfb0R10IPm
 N8PyvXVj0j9wRenL8hB6fjJrQzbwX014rZoutjw0cRStjHDrNpPHaAaX5PkRToaHgqU1
 6e+4E9+CH00Eb5FByz6uc3AT+c48FEj55S9X1rBW5fGys2nifRMF4bJw07xFBTNzdM47
 uP9/Lwi4EEvfdvemXkvq9cJy/5rwwp/F+UZ80bhqlLh2uHsvn3lUoO92goH/LnMrX7QJ
 ZwIA==
X-Gm-Message-State: APjAAAV7nG87D9HV84Xx5zAoRzR+lF/BygaYob4vvj18osR4e5HkqfOW
 W/PtK5jXYIbMLkksfdhDE2S7SQ==
X-Google-Smtp-Source: APXvYqyrMC4qUZGMDa4vTDXPc+WMRe1Cedi+NXO2t/JRWGPthrCa8hHpKeJ8ml5/0kP4fhuDUvDeMQ==
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr1802033wrw.126.1578640555220; 
 Thu, 09 Jan 2020 23:15:55 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id x17sm1129827wrt.74.2020.01.09.23.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 23:15:54 -0800 (PST)
Date: Fri, 10 Jan 2020 08:15:47 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 00/13] iommu: Add PASID support to Arm SMMUv3
Message-ID: <20200110071547.GA959441@myrica>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20200109143618.GA942461@myrica>
 <20200109144100.GD12236@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200109144100.GD12236@willie-the-truck>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 guohanjun@huawei.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, sudeep.holla@arm.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On Thu, Jan 09, 2020 at 02:41:01PM +0000, Will Deacon wrote:
> On Thu, Jan 09, 2020 at 03:36:18PM +0100, Jean-Philippe Brucker wrote:
> > On Thu, Dec 19, 2019 at 05:30:20PM +0100, Jean-Philippe Brucker wrote:
> > > Add support for Substream ID and PASIDs to the SMMUv3 driver. Since v3
> > > [1], I added review and tested tags where appropriate and applied the
> > > suggested changes, shown in the diff below. Thanks all!
> > > 
> > > I'm testing using the zip accelerator on the Hisilicon KunPeng920 and
> > > Zhangfei's uacce module [2]. The full SVA support, which I'll send out
> > > early next year, is available on my branch sva/zip-devel at
> > > https://jpbrucker.net/git/linux/
> > 
> > Is there anything more I should do for the PASID support? Ideally I'd like
> > to get this in v5.6 so I can focus on the rest of the SVA work and on
> > performance improvements.
> 
> Apologies, I'm just behind with review what with the timing of the new
> year. You're on the list, but I was hoping to get Robin's TCR stuff dusted
> off so that Jordan doesn't have to depend on patches languishing on the
> mailing list and there's also the nvidia stuff to review as well.
> 
> Going as fast as I can!

No worries, I just wanted to check that it didn't slip through the cracks.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
