Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E98C433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 10:03:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C889340234;
	Tue, 22 Mar 2022 10:03:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pwFXDSI4yHRk; Tue, 22 Mar 2022 10:03:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 790A44022B;
	Tue, 22 Mar 2022 10:03:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3718FC0012;
	Tue, 22 Mar 2022 10:03:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E43F3C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 10:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9871611E3
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 10:03:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nj5ICXZFfb3S for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 10:03:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3BC2611DC
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 10:03:09 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id bi12so35114200ejb.3
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Jr6+3DLiK22UGPA/4UCdBp/K4JK2YnXWo0BRCRlc9P4=;
 b=oua8H4T2ABH4Fxb1AEHnQqs0+Nd/DRrkBFpa5TciYJATj1RP0krVsGQpLeZsaxvYF0
 N+Urr+Hx/Kh6pC+k2QptfrGexg2ley1p7XYCdfZWE8Ivu73f9AgKKmG7hf8lkXf8bzw/
 Z0NpdKYwpTQ+sJ9mMM5PlAZ0202v6wMvFE1o21BYlWi/zNDQglcErQlVwqDDxe4Js9dl
 fj2WRHeMhjOc4rbk/7y4lwFGU3IDEhGkHDXbNd5e70/+yzvGNxFbETpiUdqHdrImVWZg
 g1I7jnZOvGlJaiRe/ibZpxZ/cfu/Dupp8Eab0RUVMo1OJaBEk82skw39t9scygaCuyfe
 8a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Jr6+3DLiK22UGPA/4UCdBp/K4JK2YnXWo0BRCRlc9P4=;
 b=hPFTpZmNySGwRiOTha3sKiIutAYKY+RoRbHnLopU3oz3zsQS8JoReCG2jE5lwD6koR
 HK03Vb6nsHphfOud5Hw1igq3jGMs8MuCPepR+enrVtjGfpDgV+g3Dk7BkjSTMr8aBg2/
 9S/+Fck3YzXrart+OT217PR7XPcg55+Oh4v4XlddfEPrT6KC9CTxzNFp9tx1BQ9M1ikl
 x6RJ2EKlv/GkG1bQnTawUwk600KA9cmtFgvGYmu6JClREjxvFYFODx9GvbFFrfgAJmhL
 UXfPv4EjCFRNSxH0OZ4jQnj9aFm8nmO434BVA9UFWJ4Z5gcB2T6Ub3wUfjjPlpDHbpDD
 1ydQ==
X-Gm-Message-State: AOAM5333UJz5kQOuZXx0ce6n0ZJKsKf5nMxmCG18Co0xetcDVmdDcDpy
 xiPN/+JrWZUkYKs28NAkbN/HVw==
X-Google-Smtp-Source: ABdhPJwSJoDYsl+ypeZ55jb14aW2EgS7Ir7T4NruIJDojVC2fATtynQ+pT99XhjRyuMJT6TZzCejFw==
X-Received: by 2002:a17:907:6092:b0:6db:ab31:96a2 with SMTP id
 ht18-20020a170907609200b006dbab3196a2mr23916489ejc.361.1647943386426; 
 Tue, 22 Mar 2022 03:03:06 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 sd33-20020a1709076e2100b006e0339b4a5asm1216694ejc.109.2022.03.22.03.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 03:03:06 -0700 (PDT)
Date: Tue, 22 Mar 2022 10:02:41 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Message-ID: <YjmeweWTTUtPztYz@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YjhkmDEGwF4EcM8R@myrica> <20220321124346.GP11336@nvidia.com>
 <64fa931b-ea2d-f425-5baa-654216bac779@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <64fa931b-ea2d-f425-5baa-654216bac779@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Will Deacon <will@kernel.org>
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

On Tue, Mar 22, 2022 at 01:03:14PM +0800, Lu Baolu wrote:
> On 2022/3/21 20:43, Jason Gunthorpe wrote:
> > On Mon, Mar 21, 2022 at 11:42:16AM +0000, Jean-Philippe Brucker wrote:
> > 
> > > I tend to disagree with that last part. The fault is caused by a specific
> > > device accessing shared page tables. We should keep that device
> > > information throughout the fault handling, so that we can report it to the
> > > driver when things go wrong.
> > SVA faults should never be reported to drivers??
> > 
> 
> When things go wrong, the corresponding response code will be responded
> to the device through iommu_page_response(). The hardware should then
> report the failure to the device driver and the device driver will
> handle it in the device-specific way. There's no need to propagate the
> I/O page faults to the device driver in any case. Do I understand it
> right?

In theory yes, but devices don't necessarily have the ability to report
precise errors, we may have more information.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
