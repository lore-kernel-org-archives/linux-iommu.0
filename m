Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71D9C5321D
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 09:54:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31AA217D8
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 09:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYpPR8OT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31AA217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7B111845D2;
	Thu,  9 Apr 2020 09:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NVvEZcoJTSwe; Thu,  9 Apr 2020 09:38:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EE6028452E;
	Thu,  9 Apr 2020 09:38:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9E5EC1D7E;
	Thu,  9 Apr 2020 09:38:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A1EAC0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2616B84519
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T281FXAC86cN for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 09:38:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 13B4384413
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:38:49 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id s8so11124634wrt.7
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 02:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TUDoLKMMdHMR1rZNFcHOOtCZYFU9bh9JO/aemHvhjFk=;
 b=jYpPR8OTb2GGh/MMhOBz3qkV5a8N2A6Gz3Of3JWdBmSlWODObZq+oeuRnxnFnyrov1
 TALT9vbCUEF14fW9cphDRYFxAFq4fWeB/IBODCAdEBKDh1i80RzE3AkmZiKSk+aIrFQm
 3AARvtT5Kb0HTFBjcA4VwdDfk1x0QFZmiWIizxLG18zsQDj31PwUpJhjs9dfPzp+X4La
 /AmaK5dH9ZSPvQueveNNFLTAOapbu+XgTg/y0LNqXd9T7Vub0E5dmLiYcLLDefOeqmaj
 NaU5ezsjDcIgctN7UpNnTD7r/Sn/F2KpybWn7ajy+B7uS5/Ojud58INLA7awb4/CPxNg
 w33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TUDoLKMMdHMR1rZNFcHOOtCZYFU9bh9JO/aemHvhjFk=;
 b=IuGFxMYKIYdIuaUd25IxEx/SWsWhblQ9ziSiixr0+a8Nuhi5ywVSEEby2uTv8fj8I4
 1lUzvrVaUNTrWqGAio7A+WqsBzCAxGDRerZFKZthAJt8tmSBqNrPhIkBU49eTWhFAEvh
 BWTiyV34rGe4spy/H06fY7AenkMWWD0gXGwYheUFx/BWVmKLni4BYJnv+NSbx+mo0lZZ
 ooxazvYlMx4EZikyMZFwzGTALQTBhzNRN0zDb9nGOeGPwadDDr7Zi8UuXqpeqeF/nUd5
 d5dRFjc9jdF9RzlBFTGgvups4gxlSQThX+mbupSQrIdfNhkikPf0apMde1ZknIQBHqUZ
 6jZA==
X-Gm-Message-State: AGi0PuYkSbLiNdPDj85yK72us2GoqE1KO6sk+1IlO6Ko5ZUi49RrFlwZ
 K46R7wi1rRTfbTo+Fpaf0SOdow==
X-Google-Smtp-Source: APiQypJ/bOyornodYdSyYMQSu94F2GYB/q88uLGGOOtbI4H/O4Jr8LdPoj7N2VqvqFNCove+bm0Wfw==
X-Received: by 2002:a5d:5143:: with SMTP id u3mr13924339wrt.64.1586425127458; 
 Thu, 09 Apr 2020 02:38:47 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m8sm2922990wmc.28.2020.04.09.02.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 02:38:46 -0700 (PDT)
Date: Thu, 9 Apr 2020 11:38:39 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 6/8] vfio/type1: Bind guest page tables to host
Message-ID: <20200409093839.GH2435@myrica>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-7-git-send-email-yi.l.liu@intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF98F@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A21D8C6@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D805F75@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A21ED01@SHSMSX104.ccr.corp.intel.com>
 <20200403083407.GB1269501@myrica>
 <A2975661238FB949B60364EF0F2C25743A224C8F@SHSMSX104.ccr.corp.intel.com>
 <20200409082846.GE2435@myrica>
 <A2975661238FB949B60364EF0F2C25743A228CCA@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A228CCA@SHSMSX104.ccr.corp.intel.com>
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

On Thu, Apr 09, 2020 at 09:15:29AM +0000, Liu, Yi L wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Sent: Thursday, April 9, 2020 4:29 PM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > 
> > On Tue, Apr 07, 2020 at 10:33:25AM +0000, Liu, Yi L wrote:
> > > Hi Jean,
> > >
> > > > From: Jean-Philippe Brucker < jean-philippe@linaro.org >
> > > > Sent: Friday, April 3, 2020 4:35 PM
> > > > Subject: Re: [PATCH v1 6/8] vfio/type1: Bind guest page tables to host
> > > >
> > > > On Thu, Apr 02, 2020 at 08:05:29AM +0000, Liu, Yi L wrote:
> > > > > > > > > static long vfio_iommu_type1_ioctl(void *iommu_data,
> > > > > > > > >  		default:
> > > > > > > > >  			return -EINVAL;
> > > > > > > > >  		}
> > > > > > > > > +
> > > > > > > > > +	} else if (cmd == VFIO_IOMMU_BIND) {
> > > > > > > >
> > > > > > > > BIND what? VFIO_IOMMU_BIND_PASID sounds clearer to me.
> > > > > > >
> > > > > > > Emm, it's up to the flags to indicate bind what. It was proposed to
> > > > > > > cover the three cases below:
> > > > > > > a) BIND/UNBIND_GPASID
> > > > > > > b) BIND/UNBIND_GPASID_TABLE
> > > > > > > c) BIND/UNBIND_PROCESS
> > > > > > > <only a) is covered in this patch>
> > > > > > > So it's called VFIO_IOMMU_BIND.
> > > > > >
> > > > > > but aren't they all about PASID related binding?
> > > > >
> > > > > yeah, I can rename it. :-)
> > > >
> > > > I don't know if anyone intends to implement it, but SMMUv2 supports
> > > > nesting translation without any PASID support. For that case the name
> > > > VFIO_IOMMU_BIND_GUEST_PGTBL without "PASID" anywhere makes more
> > sense.
> > > > Ideally we'd also use a neutral name for the IOMMU API instead of
> > > > bind_gpasid(), but that's easier to change later.
> > >
> > > I agree VFIO_IOMMU_BIND is somehow not straight-forward. Especially, it may
> > > cause confusion when thinking about VFIO_SET_IOMMU. How about using
> > > VFIO_NESTING_IOMMU_BIND_STAGE1 to cover a) and b)? And has another
> > > VFIO_BIND_PROCESS in future for the SVA bind case.
> > 
> > I think minimizing the number of ioctls is more important than finding the
> > ideal name. VFIO_IOMMU_BIND was fine to me, but if it's too vague then
> > rename it to VFIO_IOMMU_BIND_PASID and we'll just piggy-back on it for
> > non-PASID things (they should be rare enough).
> maybe we can start with VFIO_IOMMU_BIND_PASID. Actually, there is
> also a discussion on reusing the same ioctl and vfio structure for
> pasid_alloc/free, bind/unbind_gpasid. and cache_inv. how about your
> opinion?

Merging bind with unbind and alloc with free makes sense. I'd leave at
least invalidate a separate ioctl, because alloc/bind/unbind/free are
setup functions while invalidate is a runtime thing and performance
sensitive. But I can't see a good reason not to merge them all together,
so either way is fine by me.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
