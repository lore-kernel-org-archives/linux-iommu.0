Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404675403
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="okmrgH24"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-67adac40221so41281366d6.2
        for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 07:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702394088; x=1702998888; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yf/vxoxAPU7AjoQT7h5u+3hNOV3CcW9wSJKxeUZD+0Q=;
        b=okmrgH24NZz/Zix1DzshloGxYul94Vu2PLheEYJXAnqSOoGcjLQeCio6voyYJOAX+g
         nP4qdJB3bisdnPs1DbAGp6pJnuoYpGiu7iwfW4PSLvB1O86onUSg5LnMV0GShKQxPSqa
         t3ieFeQTuRZZBbRzkQ8vm3WGlT18zHP0l52xg8dP3ZKorIT3pKhhsMlvsU6MyMDaIZds
         cMoDrWa3U8Bs/5VRIbB0c8HoaxWIFPYr3qkm3iCXqhjG2Uqa1aJto1zjHZAxZx0xa0Iu
         GmPnPuwFGNOy/EmPHmQWd07CP7tVXE9Q55gSwBqqsAXkXJFSR+vMDDUl4h0Odi9UjXN4
         Cysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394088; x=1702998888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf/vxoxAPU7AjoQT7h5u+3hNOV3CcW9wSJKxeUZD+0Q=;
        b=M3Aq4HlgtXSILDp1nQeqj3O//rprMvB2xL3HXs1Q5oaB5Xff0ZKMxK102yz3RUbJco
         mysGNlRoRqh1/T3pkFsmxxxtDYna/9G7T8NsXcJ30YXKO5y5YWj8hWv13INIYjJMZqff
         +3j4M5Nf6pJtVVfYBPtwEYFXmMwDU2/6TAGMvTUNLtr2XLxxOFzUFxeavJQYda7N3A2m
         ibs7MN4JEpuIUcm76wY1YLLRIfduB9BAqlmRUUYjJdUBrPKS6O4EzmD91859mxk/NXlE
         d5DYFFbVKHIbIhFvvIf9z3ic+6dRMiBql/JapyfVMJkKi0j4rrP0T2sFO1c7HLrR5+AR
         eJbA==
X-Gm-Message-State: AOJu0Yx4M8s2+hr+Rq4Fa9Gfa+hbMTy+ko++YfKDEykAiXgzogLazXna
	H9NJnkdobrpkwxHtL8SAu+J6Bg==
X-Google-Smtp-Source: AGHT+IGO0U0gsQvPEQe12yrbRz8NbA/1wHR/0MK9Uqm+C0W3pgcHg4DAVW0sKOtW1Iga6sBwe4Qurg==
X-Received: by 2002:ad4:5146:0:b0:67e:ed9e:d217 with SMTP id g6-20020ad45146000000b0067eed9ed217mr730301qvq.24.1702394088317;
        Tue, 12 Dec 2023 07:14:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id n7-20020a0ce947000000b0067a53851126sm4267023qvo.98.2023.12.12.07.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:14:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rD4T9-00Ck0Y-AN;
	Tue, 12 Dec 2023 11:14:47 -0400
Date: Tue, 12 Dec 2023 11:14:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] iommu: Use refcount for fault data access
Message-ID: <20231212151447.GC3013885@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-13-baolu.lu@linux.intel.com>
 <20231211152456.GB1489931@ziepe.ca>
 <416b6639-8904-4b31-973c-d5522e2731d8@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <416b6639-8904-4b31-973c-d5522e2731d8@linux.intel.com>

On Tue, Dec 12, 2023 at 01:17:47PM +0800, Baolu Lu wrote:
> On 12/11/23 11:24 PM, Jason Gunthorpe wrote:
> > Also iopf_queue_remove_device() is messed up - it returns an error
> > code but nothing ever does anything with it 🙁 Remove functions like
> > this should never fail.
> 
> Yes, agreed.
> 
> > 
> > Removal should be like I explained earlier:
> >   - Disable new PRI reception
> 
> This could be done by
> 
> 	rcu_assign_pointer(param->fault_param, NULL);
> 
> ?

Not without a synchronize_rcu

disable new PRI reception should be done by the driver - it should
turn off PRI generation in the IOMMU HW and flush any HW PRI queues.

> >   - Ack all outstanding PRQ to the device
> 
> All outstanding page requests are responded with
> IOMMU_PAGE_RESP_INVALID, indicating that device should not attempt any
> retry.

Yes

Jason
