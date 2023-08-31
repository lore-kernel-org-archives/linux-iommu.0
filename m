Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E3E57F
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 16:56:23 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-26d50a832a9so753734a91.3
        for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693500983; x=1694105783; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FffvsGWG4o/+MK35eQ6fKF+ifwU5eNn4Zb6qXJqhIH0=;
        b=T6Fc4h+lFWbhyv5WaXc/qcMIsV3y3uGYahG3CcmjsIWUkbx4xLQPiQ64GWv4gXTT54
         OzxegiWtjARlOqOGP2+tWHUuKK8VRkyleeEJ1+27L3td8RgBsK2ZjHQQCm0pJ5AiT3Jp
         DktbZUbr9E23fBPw6QOZJ2UklLILyxovH1d7U9jsZebwGM/cz2EGtxgdwOssgzzJMiDj
         T0cG68fL5/Z4Dj4+5/koo8gsCDrJ23zN++Dga2G2+ASOI6T1JEowmk81Xzna0gz6QMV1
         8eOF0rGyEADfJull7K7kkUeeLZwb4PUtjfXM5JWZ4TxjPUSchmHbGKqWOciif8UEEbO2
         Ifsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693500983; x=1694105783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FffvsGWG4o/+MK35eQ6fKF+ifwU5eNn4Zb6qXJqhIH0=;
        b=YNH/DVcU0c47bY5RtS6lWCl++tL03xgsX18Fws1m+JFMimCSa2fmhMXoZRYukcVT18
         x9mfiVHn3lxl+5Rv7rb2UJMEY0aWwHjaP0SKK3j9O8Ogwv8HPcwVGqBoMafW/xkBBBGS
         Bij2UTJLpiG7BCYLxXZvZ+T+1WPJ4fXd4SVZtDe5CO2xRAx4w4I9X45Iamh9iK/81SFq
         7mT6er4LiNlWwHCk0BGobWF+1QSCIfW77S9pO3QS3IJUvCeEUWfUacls3VrTMzGNqBf9
         J03jI0SE+jz4Nhs14V0C0+LMgGtJrtp8iiAmOdtjgGruxjgzOV2rF+CE93U1tWVOebw7
         +JOg==
X-Gm-Message-State: AOJu0Yyavuxl/5wMBQPeOXnqY7Jbo+0AL8Uz5EZ1S1qudUxDTwuzYaYG
	X2PN+uCq6MUbYgcJ7XoI6ziAeQ==
X-Google-Smtp-Source: AGHT+IEDI82NNXCwkshM+WujgWXe/Jzh4lytCdzF/QQCVfGPB/aRcv+Fr0DY8KJZhMpGMHpYM4uDYQ==
X-Received: by 2002:a17:90b:4b0d:b0:271:7ce5:2575 with SMTP id lx13-20020a17090b4b0d00b002717ce52575mr5041222pjb.22.1693500982856;
        Thu, 31 Aug 2023 09:56:22 -0700 (PDT)
Received: from ziepe.ca ([207.140.200.197])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a1a4500b0026b4ca7f62csm1666361pjl.39.2023.08.31.09.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 09:56:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qbkxv-000IS8-9F;
	Thu, 31 Aug 2023 13:56:19 -0300
Date: Thu, 31 Aug 2023 13:56:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Tina Zhang <tina.zhang@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iommu: Support mm PASID 1:n with sva domains
Message-ID: <ZPDGM2YWvTAhk4tE@ziepe.ca>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-5-tina.zhang@intel.com>
 <aa834f12-ce45-fe15-430b-2a9c3446a5ba@amd.com>
 <ZO+oRPOf9jyNG2+B@ziepe.ca>
 <20b44fe8-33ba-d6ae-110e-a82a19390bcc@amd.com>
 <ef751928-7123-6840-f080-ca63e24e5ece@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef751928-7123-6840-f080-ca63e24e5ece@linux.intel.com>

On Thu, Aug 31, 2023 at 03:35:36PM +0800, Baolu Lu wrote:
> On 2023/8/31 14:42, Vasant Hegde wrote:
> > > > Also in this function (mm_pasid_drop()), should we check/free sva domains?
> > > No, the driver must support a SVA domain with an empty mm_struct, eg
> > > by hooking release.
> > Sorry. Looks like confused you. Looking into code I got this.
> > 
> > My question was: when PASID is enabled, is there any chance of mm_pasid_drop()
> > getting called before freeing all SVA domains?
> 
> I remember we have discussed this during sva development. If I remember
> it correctly, in any case, mm_pasid_drop() will be called after the
> device is closed. 

Yes, we guarentee this because the SVA domain should be holding a
mmgrab on the mm_struct while it exists. The mmdrop cannot happen
until the SVA domain is freed which puts back that ref.

But drivers must not make any assumptions about this, the lifecycle of
the PASID is a core concern, so long as the driver is asked to attach
a domain to a PASID it should assume the PASID is valid.

A driver should *never* look at the mm_struct PASID, all the examples
of this in-tree today are wrong.

Jason
