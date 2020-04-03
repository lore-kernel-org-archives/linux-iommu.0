Return-Path: <SRS0=dWuT=5T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A229CC2D0E8
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 12:40:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA80208FE
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 12:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptml5nxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA80208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3FDC22041B;
	Fri,  3 Apr 2020 12:40:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hOOVy-qRaGyU; Fri,  3 Apr 2020 12:40:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3E7CB2033E;
	Fri,  3 Apr 2020 12:40:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2222CC1AE2;
	Fri,  3 Apr 2020 12:40:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 178CCC07FF
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 12:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 007C8870F7
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 12:40:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6tqc3NbPLytF for <iommu@lists.linux-foundation.org>;
 Fri,  3 Apr 2020 12:40:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 82CAD870E0
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 12:40:01 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id s8so6206091wrt.7
 for <iommu@lists.linux-foundation.org>; Fri, 03 Apr 2020 05:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4UoTuchVPcQbessFRne4dgixRRmQ3IULpwTbXSdSKjI=;
 b=ptml5nxSRSHJqKFQi24/vBmgB1JRiVOfz6FKiC4gpmUxkWrdbIyK3uvOqzLg5W8uwh
 yk1CyLp9obg1oU+Hr7N6V0Qazv6OJMEPqjaiFOV+KsBE1iJSqdyMfGbI2Rl+ueZPP0RD
 q7v1i7bZgnoLW05nP9LCgF1a+3JHpfALZxf0xfNQn1SzUNgm31+sKib0d1IHusr6S6GN
 S3M6fCUQu+ra4TFkCP3PW0+YRlA/SrhwExhXWORiYZ0CKq/Y1szY6G0V/0lW1/+ql3PT
 vjcqmIc/VrpfqtHRjppi/1GU3b/+N4+HcwayMIoWnVrI9mhF+z3SZAPdivgHOcuQhmg3
 M9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4UoTuchVPcQbessFRne4dgixRRmQ3IULpwTbXSdSKjI=;
 b=lWejLq5nao671Xy+WYI+BGHMYvhQg9wM2XWF1FW43jyqc67/PvbjxgDwdrmx+RLqiu
 Lg+luTdbS0bzOiqxdBDbHuB0WTg92G743YSzRw4oMh7CxoU1UQeyL2O49kG/RbG1xz5w
 CPaqEmFWM6QAExBgy5Ed/gvnciFxDgc3WhOUxQm67aE9KVEjwL+t+Y0/P4epLjH5xP90
 qt2faTRX2ikYOMhfQPFIjnBlioqK30qHuYsXIDDlzpsvs949KvJHQ6mnVhoq8rIFM/Lo
 Udk8+HjDzf5D+8nBVPSrzzKpK9xmFMAVONb95RGqeY8c6gmbjdr/2iFG0ZlVuJA4+cdQ
 3KOg==
X-Gm-Message-State: AGi0PuYHCXzwW5gMpGjaDfGOW0DKvmKbZiCVzr9CGBYyGWgXt5QbgGBL
 MgT2E7Y6hYUkRRvJFOYR8XEdYw==
X-Google-Smtp-Source: APiQypJxxsi5NWBorLzelVFk5jRcSOCtWuTo4mTy/DlCSSr3s65XnB3k77Ei4DFGaxZmRYKmvHULRg==
X-Received: by 2002:a5d:44c3:: with SMTP id z3mr8800515wrr.284.1585917599670; 
 Fri, 03 Apr 2020 05:39:59 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id 91sm5994296wrf.79.2020.04.03.05.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 05:39:59 -0700 (PDT)
Date: Fri, 3 Apr 2020 14:39:51 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Message-ID: <20200403123951.GA1410438@myrica>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-2-git-send-email-yi.l.liu@intel.com>
 <20200402135240.GE1176452@myrica>
 <A2975661238FB949B60364EF0F2C25743A2209E3@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A2209E3@SHSMSX104.ccr.corp.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Fri, Apr 03, 2020 at 11:56:09AM +0000, Liu, Yi L wrote:
> > >  /**
> > > + * VFIO_MM objects - create, release, get, put, search
> > > + * Caller of the function should have held vfio.vfio_mm_lock.
> > > + */
> > > +static struct vfio_mm *vfio_create_mm(struct mm_struct *mm)
> > > +{
> > > +	struct vfio_mm *vmm;
> > > +	struct vfio_mm_token *token;
> > > +	int ret = 0;
> > > +
> > > +	vmm = kzalloc(sizeof(*vmm), GFP_KERNEL);
> > > +	if (!vmm)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	/* Per mm IOASID set used for quota control and group operations */
> > > +	ret = ioasid_alloc_set((struct ioasid_set *) mm,
> > 
> > Hmm, either we need to change the token of ioasid_alloc_set() to "void *",
> > or pass an actual ioasid_set struct, but this cast doesn't look good :)
> >
> > As I commented on the IOASID series, I think we could embed a struct
> > ioasid_set into vfio_mm, pass that struct to all other ioasid_* functions,
> > and get rid of ioasid_sid.
> 
> I think change to "void *" is better as we needs the token to ensure all
> threads within a single VM share the same ioasid_set.

Don't they share the same vfio_mm?

Thanks,
Jean
> 
> > > +			       VFIO_DEFAULT_PASID_QUOTA, &vmm->ioasid_sid);
> > > +	if (ret) {
> > > +		kfree(vmm);
> > > +		return ERR_PTR(ret);
> > > +	}
> > > +
> > > +	kref_init(&vmm->kref);
> > > +	token = &vmm->token;
> > > +	token->val = mm;
> > 
> > Why the intermediate token struct?  Could we just store the mm_struct
> > pointer within vfio_mm?
> 
> Hmm, here we only want to use the pointer as a token, instead of using
> the structure behind the pointer. If store the mm_struct directly, may
> leave a space to further use its content, this is not good.
> 
> Regards,
> Yi Liu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
