Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5202FC433F5
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 16:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F068D83E30;
	Tue, 26 Apr 2022 16:48:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qOF3_pnj8Or9; Tue, 26 Apr 2022 16:48:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B477283E2F;
	Tue, 26 Apr 2022 16:48:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8873DC0032;
	Tue, 26 Apr 2022 16:48:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E88C3C002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 16:48:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CFDE441880
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 16:48:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cxOrUPyw490L for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 16:48:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AA244185B
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 16:48:30 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id j6so3434342ejc.13
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=D5d/UcR8WWtwm14ZrH9Ny0PXpXXCcP8eFt6zg75qTSg=;
 b=yMnq6FHdIFP459zaK7zNPCwuRcpBpup0Y1hoR3dAu5PPSw7HQd07CTlTZ9YCPonIId
 ZQAGvu+x/52Q9qIGRZmn19hqTyWABcsgcKEFHr0tOLHNk1zKpB/zVNVwnUr6cfv8iGoM
 4eUW78aeT6k0GqobuS7hJJxguXWLDkQCn2gZakfxyOQYb6z8z1t51xjefG3z7RCOVXRN
 ll2reAII6TC0sdef0SoidM2Fp2/WFZp+kA4p09I3WY8dyGRV1vfNz4aInSOfOlO/7eM6
 8cWAp66JfasHp/hw7TWyXOglVjWCSUPvzyOs6OaeoBWH6Ez0psTrqiAs4XVQ9AL79CgC
 PzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D5d/UcR8WWtwm14ZrH9Ny0PXpXXCcP8eFt6zg75qTSg=;
 b=e3umS4S5tJq6nJuNQOcFv+55gNyNtKOTeevEltTw4zmiRP+n72ZvgpzTN2ji6xqGeq
 wXHrmT1Lq20MImMlnGqx7D/utAQ2SdGs0X2IlJ1Ho4M6sM0isaEmnambhSQ1le65fdbA
 5wfSXhRK/fAmD8hbzHhkrANK5SZJTksP08+RVo27TL2NyxWlMOkByeOi7Nu6DfUuOrmh
 8w13Fev1HHcBxVyt90Iw2MG8j8i6cfO+QZKChrNeZdLUVH0KhhrpuHdW1CiQMnziBNEM
 A+MsKP4ZCQOB9gCY36mpQZrUjL5Kra1fM/LnW5XDs77+WqBthHxMMpbVITg5aJjd+HbO
 F8xg==
X-Gm-Message-State: AOAM533z7oIz8OUEvfsaSlY363rMwPLagEOv6EZnKxB+wvXsHmskPieT
 VNZ9smp+mXeuktzQd2aQrAkLtA==
X-Google-Smtp-Source: ABdhPJzrAtI4rer1zqBksVvk+bjUCWF1lDnl3p29wyqsYQRedTzX6mxZ5ycXF9qp5uSxW7pEKXAXew==
X-Received: by 2002:a17:907:868c:b0:6f2:d939:630c with SMTP id
 qa12-20020a170907868c00b006f2d939630cmr19937985ejc.211.1650991708641; 
 Tue, 26 Apr 2022 09:48:28 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 u15-20020a17090617cf00b006f3bf8e69absm133895eje.5.2022.04.26.09.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Apr 2022 09:48:27 -0700 (PDT)
Date: Tue, 26 Apr 2022 17:48:01 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmgiQZZyFxsJ+9um@myrica>
References: <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
 <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
 <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, zhangfei.gao@linaro.org,
 Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
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

On Tue, Apr 26, 2022 at 08:27:00AM -0700, Dave Hansen wrote:
> On 4/25/22 09:40, Jean-Philippe Brucker wrote:
> > The problem is that we'd have to request the device driver to stop DMA
> > before we can destroy the context and free the PASID. We did consider
> > doing this in the release() MMU notifier, but there were concerns about
> > blocking mmput() for too long (for example
> > https://lore.kernel.org/linux-iommu/4d68da96-0ad5-b412-5987-2f7a6aa796c3@amd.com/
> > though I think there was a more recent discussion). We also need to drain
> > the PRI and fault queues to get rid of all references to that PASID.
> 
> Is the concern truly about blocking mmput() itself?  Or, is it about
> releasing the resources associated with the mm?

The latter I think, this one was about releasing pages as fast as possible
if the process is picked by the OOM killer. 

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
