Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC226C2BB1D
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 08:28:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AF52082D
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 08:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwT7A41K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AF52082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 499E9848ED;
	Thu,  9 Apr 2020 08:28:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8bCDlNhDp-M9; Thu,  9 Apr 2020 08:28:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CAFBD84728;
	Thu,  9 Apr 2020 08:28:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B924DC089F;
	Thu,  9 Apr 2020 08:28:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 518BAC0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 08:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 40E5F84867
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 08:28:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GGQkyFGXy6Cb for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 08:28:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4D4F684728
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 08:28:56 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id g3so10928571wrx.2
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 01:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WgrtA3z9gcCpvVtn+/QtJVLHi+wEpZ3q6REO1Dlhxjc=;
 b=EwT7A41KDLkk8jDmuwXWJhwVkRRmXWA9OX4bUYtDtbxYJW+BezFqEYR2LyeY8NYE1n
 qsISncWQMRghInp7uM9xVtUlfEZTQzsVHplk5XeWwX6PkZMXqZwF4UMtYgj3zaNm+RrD
 tLmAnD7ijZbtkbWHYzv5URL/0X1eKDlkHVJzC329EMt0/pbrkBtiSa/dy1S0jYkDDbZD
 8+g568tPwHC1C8QI/NhKp5kQqGO7edSzI4Gt3SfIt/ysuGcApiyrZMbxGdKzImTfyZZP
 G2Sh69tPb6Gm1lN6ndVUe9rhMwabrdl5f/Q41dh8Js0FocrCVYBIK0HVBzk1FugewyrL
 PNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WgrtA3z9gcCpvVtn+/QtJVLHi+wEpZ3q6REO1Dlhxjc=;
 b=h8z0V+gBVcVMQ1xLpkMe8QHXU2YtfWFhIPcwpJtbqqkUCWl5DN7t8KCs+8PV/xIj8F
 Ti+BwbGOF/sXIWgdKmXUXHEXgt8uxbG6QwDkBwZvHw+g5D6WWTRV6vMW6Xk2pwDgOVyw
 fSB17yRQlBi+Ia5+UHzHK24GDpbV+GvkcC1BVEC4io6x/OeY2+ojKUTNzIUNbhgybnef
 duyhayxT8dviCCUWE3IhWL7w8IvAMHtKh3Poj8MYqfHpOjCrJ1UzhHAIyfXKF17MEuBF
 YAh/UsaxKaC1WVj++jO3gqxwm7bcDK2hWY99BsC0kfOVGn7pZEKKupozm/2jE2lBWX7s
 Ix8w==
X-Gm-Message-State: AGi0PuZTiR4Jcm383c5Io2c7+UvTxVyLuspuCVma86PRIjk29c7r+uzB
 kHzXOGOp9a8KMHJmQro+GkYijg==
X-Google-Smtp-Source: APiQypJaUZjUm66IBuu3xDJVpLpWtuc3y+tz9J81OOkTIgI1piB2pLEQNhoBRvX1GGgS2ZUyboZgLw==
X-Received: by 2002:adf:e641:: with SMTP id b1mr12714165wrn.299.1586420934729; 
 Thu, 09 Apr 2020 01:28:54 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id p5sm14167665wrn.93.2020.04.09.01.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 01:28:54 -0700 (PDT)
Date: Thu, 9 Apr 2020 10:28:46 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 6/8] vfio/type1: Bind guest page tables to host
Message-ID: <20200409082846.GE2435@myrica>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-7-git-send-email-yi.l.liu@intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF98F@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A21D8C6@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D805F75@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A21ED01@SHSMSX104.ccr.corp.intel.com>
 <20200403083407.GB1269501@myrica>
 <A2975661238FB949B60364EF0F2C25743A224C8F@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A224C8F@SHSMSX104.ccr.corp.intel.com>
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

On Tue, Apr 07, 2020 at 10:33:25AM +0000, Liu, Yi L wrote:
> Hi Jean,
> 
> > From: Jean-Philippe Brucker < jean-philippe@linaro.org >
> > Sent: Friday, April 3, 2020 4:35 PM
> > Subject: Re: [PATCH v1 6/8] vfio/type1: Bind guest page tables to host
> > 
> > On Thu, Apr 02, 2020 at 08:05:29AM +0000, Liu, Yi L wrote:
> > > > > > > static long vfio_iommu_type1_ioctl(void *iommu_data,
> > > > > > >  		default:
> > > > > > >  			return -EINVAL;
> > > > > > >  		}
> > > > > > > +
> > > > > > > +	} else if (cmd == VFIO_IOMMU_BIND) {
> > > > > >
> > > > > > BIND what? VFIO_IOMMU_BIND_PASID sounds clearer to me.
> > > > >
> > > > > Emm, it's up to the flags to indicate bind what. It was proposed to
> > > > > cover the three cases below:
> > > > > a) BIND/UNBIND_GPASID
> > > > > b) BIND/UNBIND_GPASID_TABLE
> > > > > c) BIND/UNBIND_PROCESS
> > > > > <only a) is covered in this patch>
> > > > > So it's called VFIO_IOMMU_BIND.
> > > >
> > > > but aren't they all about PASID related binding?
> > >
> > > yeah, I can rename it. :-)
> > 
> > I don't know if anyone intends to implement it, but SMMUv2 supports
> > nesting translation without any PASID support. For that case the name
> > VFIO_IOMMU_BIND_GUEST_PGTBL without "PASID" anywhere makes more sense.
> > Ideally we'd also use a neutral name for the IOMMU API instead of
> > bind_gpasid(), but that's easier to change later.
> 
> I agree VFIO_IOMMU_BIND is somehow not straight-forward. Especially, it may
> cause confusion when thinking about VFIO_SET_IOMMU. How about using
> VFIO_NESTING_IOMMU_BIND_STAGE1 to cover a) and b)? And has another
> VFIO_BIND_PROCESS in future for the SVA bind case.

I think minimizing the number of ioctls is more important than finding the
ideal name. VFIO_IOMMU_BIND was fine to me, but if it's too vague then
rename it to VFIO_IOMMU_BIND_PASID and we'll just piggy-back on it for
non-PASID things (they should be rare enough).

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
