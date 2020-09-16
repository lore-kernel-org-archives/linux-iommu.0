Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740FFC433E2
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 16:21:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051F5206A5
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 16:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAw6eQdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051F5206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A17A887228;
	Wed, 16 Sep 2020 16:21:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5AMASxDpE8A3; Wed, 16 Sep 2020 16:21:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id ED07687221;
	Wed, 16 Sep 2020 16:21:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8DA3C0859;
	Wed, 16 Sep 2020 16:21:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A53A6C0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 16:21:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9351687347
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 16:21:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P-lJj5XCoBLf for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 16:21:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 982078702F
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 16:21:12 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id w2so3372498wmi.1
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 09:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=g0JgrWFzihrjVNM/RM97BMwwjlCtIPznA6TNm/molSw=;
 b=aAw6eQdBpE7GtAmG/rhsFEmSpYrC8VM6bVOy+Ki9gIzm5zO4GmCuFCsga/gDel+cyz
 RT2Ax5Q5wF6wKEWvgkUIjVDYrKJAsgQI3j5JwLU/OFG2vxSGfP1kcoVWhikg3WS3ercG
 /dnk83vADJYHsGeJzvlBLjmf+uzXSlUUwhcDaN98Yr4hCO9uvgooQH31SO8MDLw/H6xX
 lNn4q0IfDgTzfD4id45l6Z5L+9jxheAH1Dajv1jBnzvwF14skKH5ZDyLyhsrILSAkVux
 pPY2AI/xaatbmnd/fidvj3hw395ODPBI4jAEFy2GmFcnMPVm1VTE+l9e6J+HS0961bVV
 IiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g0JgrWFzihrjVNM/RM97BMwwjlCtIPznA6TNm/molSw=;
 b=e0lvFdyI9Oh+3DtLKAL28iZglY6oQN3YEuNIcKggY9d6eQE7DMqnckft/7SP+xcdLx
 vSLfM9VRo6JDWdL3gIL8YxzaGasIQb0JO/Zwo/vGNUTjt+NJPwh1a1muzjgzbbWnMSFO
 t39WjpqQKXubvkFZ8Aknd56Tb4s373fWb7QE+M5y+pzLW8+U5jEx4ARwPXeCVvCMvqM5
 oU2K4hiBpfChcbzFa4vJ9wbYDEOUS15qs401I2lXrHgPM79h4OFCFOoA9tI5WkRjpkTf
 xwX7O+GEGTxaEgr5WlKbeb7/qcAny1jltj9ptPaqzvS01SuGQg4vT9cMl20YUpycRklu
 aMJQ==
X-Gm-Message-State: AOAM532R5Z8QfTIDJ+nF5nb5xiV4mZZBWwd8NzZApEu8AFJOcPLZ6Sj7
 9OYGWlvvUcRzL/ssd2oUTLDwdw==
X-Google-Smtp-Source: ABdhPJwRsqk/eXagqfhZcEsmfcd5VzH7wZXscIvOW7qb13b1cJBRB/FR2tW5PnytJ7L4dWo4B2eTzg==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr5739869wmj.174.1600273270873; 
 Wed, 16 Sep 2020 09:21:10 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s5sm33513252wrm.33.2020.09.16.09.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 09:21:10 -0700 (PDT)
Date: Wed, 16 Sep 2020 18:20:52 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200916162052.GE5316@myrica>
References: <20200914163354.GG904879@nvidia.com>
 <20200914105857.3f88a271@x1.home>
 <20200914174121.GI904879@nvidia.com>
 <20200914122328.0a262a7b@x1.home>
 <20200914190057.GM904879@nvidia.com>
 <20200914163310.450c8d6e@x1.home>
 <20200915142906.GX904879@nvidia.com>
 <MWHPR11MB1645934DB27033011316059B8C210@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200916083217.GA5316@myrica> <20200916145148.GD6199@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200916145148.GD6199@nvidia.com>
Cc: "Tian, Jun J" <jun.j.tian@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Wed, Sep 16, 2020 at 11:51:48AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 16, 2020 at 10:32:17AM +0200, Jean-Philippe Brucker wrote:
> > And this is the only PASID model for Arm SMMU (and AMD IOMMU, I believe):
> > the PASID space of a PCI function cannot be shared between host and guest,
> > so we assign the whole PASID table along with the RID. Since we need the
> > BIND, INVALIDATE, and report APIs introduced here to support nested
> > translation, a /dev/sva interface would need to support this mode as well.
> 
> Well, that means this HW cannot support PASID capable 'SIOV' style
> devices in guests.

It does not yet support Intel SIOV, no. It does support the standards,
though: PCI SR-IOV to partition a device and PASIDs in a guest.

> I admit whole function PASID delegation might be something vfio-pci
> should handle - but only if it really doesn't fit in some /dev/sva
> after we cover the other PASID cases.

Wouldn't that be the duplication you're trying to avoid?  A second channel
for bind, invalidate, capability and fault reporting mechanisms?  If we
extract SVA parts of vfio_iommu_type1 into a separate chardev, PASID table
pass-through [1] will have to use that.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/20200320161911.27494-1-eric.auger@redhat.com/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
