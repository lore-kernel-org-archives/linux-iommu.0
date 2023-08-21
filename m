Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3AF1170E
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 18:31:42 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-76ca7b4782cso249002785a.0
        for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 11:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692642701; x=1693247501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qa8AAhwTy8YVFRv18LCXMk4AitxTlf/jcp6uThOwTlI=;
        b=l5SYXEQEwNSLSpOqdZ7OFW/9Ozb1e02BEhCThpq+gziOR6jGc/3fhOTIkqj8+7DWtV
         F1/qyOcX4Sc3kjJJAxThcjvSY6ia/rdTdWclGKe+uXJqbtm2mMOObOqfvFAT+3HZw5XO
         8nu+6h+mAbl26TlNA3xmflqADodafTE2J6chgjzlYhiJ4vD7VFo3YwKo1yK8yhUMd4KV
         qky6rV59c/y93FwGgnG5ZevLbtCgovrG3VIBG/xBY07UwSROH7qEW55xflMG4wf7MLR1
         DrGkL8t6nv7iGMZ1HDBWIOqh8AaQVViFvktJV06V5CklxDcTaRhI0tQwlY1z8BZzGRXw
         gXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692642701; x=1693247501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qa8AAhwTy8YVFRv18LCXMk4AitxTlf/jcp6uThOwTlI=;
        b=avgD6naopx3Z1O7L3JaiSrXeKKoe7CaS41iwHR9Er939146q+ACSgKjLagE23rzlzD
         DAarV2TJXTCoGxQAA6braceN5B5EByyAcH8mZ6SOSqvgVoIk6/cZuipZtiEk4NvW55QG
         SolKUPodOffB+zTGsEiwdm0rZL0P6nCVcWLaDX/8zRO814sbsWIjepepT9YyjRJE580Z
         GyE+H0bdF6Z+ZkGZcs0dWQ+dXgPW5cHcfUUS7Syn1AXyMSe1lTNVk4UUE6Q83NARDi8q
         qDBJd+Bgl0w6tmJjsfvhggvsjk9Kr3aAQm4mJrUkm9N97B/vh+DIR3iQgnqA5kAxnz8P
         7G7w==
X-Gm-Message-State: AOJu0YxHzuq8c0YMW7WXwXgx6bJgd1L0iYjyeL3WNobCrUk2ZM+1BoNP
	jqJZwGt4sYaW2wcapMoU2vomEw==
X-Google-Smtp-Source: AGHT+IEJB+mpBoo2O0eM3iFfDQGTfF2egcAVTPb5TnSsKiZjFNPmdYIulJ1Rkf9qhiRRCV7nCD4Uow==
X-Received: by 2002:a05:620a:462b:b0:768:1031:4028 with SMTP id br43-20020a05620a462b00b0076810314028mr9919562qkb.30.1692642701703;
        Mon, 21 Aug 2023 11:31:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id c16-20020a05620a165000b0076da29c4497sm1316113qko.112.2023.08.21.11.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:31:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qY9gi-00DzLb-HN;
	Mon, 21 Aug 2023 15:31:40 -0300
Date: Mon, 21 Aug 2023 15:31:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/11] iommu: Prepare to deliver page faults to user
 space
Message-ID: <ZOOtjJLumarsBzwN@ziepe.ca>
References: <20230817234047.195194-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817234047.195194-1-baolu.lu@linux.intel.com>

On Fri, Aug 18, 2023 at 07:40:36AM +0800, Lu Baolu wrote:
> When a user-managed page table is attached to an IOMMU, it is necessary
> to deliver IO page faults to user space so that they can be handled
> appropriately. One use case for this is nested translation, which is
> currently being discussed in the mailing list.
> 
> I have posted a RFC series [1] that describes the implementation of
> delivering page faults to user space through IOMMUFD. This series has
> received several comments on the IOMMU refactoring, which I am trying to
> address in this series.

Looking at this after all the patches are applied..

iommu_report_device_fault() and iommu_queue_iopf() should be put in
the same file.

iommu_queue_iopf() seems misnamed since it isn't queuing anything. It
is delivering the fault to the domain.

It is weird that iommu_sva_domain_alloc is not in the sva file

iopf_queue_work() wrappers a work queue, but it should trampoline
through another function before invoking the driver's callback and not
invoke it with a weird work_struct - decode the group and get back the
domain. Every single handler will require the group and domain.

Same for domain->iopf_handler, the domain should be an argument if we
are invoking the function on a domain.

Perhaps group->domain is a simple answer.

Jason
