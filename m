Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1749620;
	Fri, 11 Nov 2022 01:46:29 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id p21so3075888plr.7;
        Thu, 10 Nov 2022 17:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7HdYeM1Wk/Qq62PaBBPXF+Pby5oSXzutxyUY3L3Tjw=;
        b=TQM1A9OGHyHLvekGPLggb7MJP/o+IB9VBA2JF8t0gD8FMJadtowHy09Z34JM/46b2R
         wTpH0lQ8BflS5+jG0vOKqVCGKWYnXKFlJqB89gsJmxNiiVe0DNejwjnJymvlwQyHiQoc
         g0ndwlHu2B8b6eRAU7byeaq4+rj+Aih2wwwPTdQ2nn37z6+dNSSfu1cJAi+C9dzPsB6q
         EeRg/mVH8W0JjkKEwRBFrZesLN5vRM4IwV50MOxuT7Z4S0D1DoIDPiQBzU4oGz260gNR
         M4IUr5SbLHuMTeEQFFjU67nIbtaRfrWv9VUmtgBO18Hv1FT866WPT+Ep/FVvMf6zowS0
         /v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7HdYeM1Wk/Qq62PaBBPXF+Pby5oSXzutxyUY3L3Tjw=;
        b=u6o63YM6bvVIpfmgELOM9jolvvrVTbg/sI08aFsYBMAbGNdaO2l6RShgmh6WFh9ZUr
         aotZmxDthKFPm+/Eybf9bgjWJLriknKzaIrp6jqw/J7qgsUqbG5Om+bSOQCdKGCMZ39t
         wdsl/WnF0eSKnyzkaBD7hN8xOOxo8G/XHxL0Z55AHWyELwfMoxIocrLD5EF/n8YmV9QK
         MRxZVFXzfJ32gG97Qce6a5dKex1Rwu87RYpch/Pi6AP1lfPUOozIRYFwzd34A+Nf3Bc3
         DQTouLPkTduaZP4jk4nwm6i8RohP7plVRdfTY4b2dNYpTTZ1/YlFd2I8fkmLb9f6DuYa
         X4qw==
X-Gm-Message-State: ANoB5pm3yi9+4Xx0R1jPAj8EEJywRjVW1clfUSo3Vdk3tnxpvvDEMyCR
	VFZ3EBZpWUzpu3HBCn93IYk=
X-Google-Smtp-Source: AA0mqf7gp2K6uu/Cr3Sggtrh7Qn5BRbs2JbSwN7nqAEB0pxAS61IUKBc/jWB4J5JumGeCw+i9zJYfg==
X-Received: by 2002:a17:903:cd:b0:186:905e:f964 with SMTP id x13-20020a17090300cd00b00186905ef964mr207154plc.162.1668131189132;
        Thu, 10 Nov 2022 17:46:29 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b0056b1ecef957sm326146pfk.37.2022.11.10.17.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 17:46:28 -0800 (PST)
Message-ID: <615a32d3-41ad-c318-9a96-4dea3c486fa0@gmail.com>
Date: Fri, 11 Nov 2022 08:46:16 +0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 04/17] iommufd: Document overview of iommufd
To: Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>
Cc: bpf@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck
 <cohuck@redhat.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eric Auger <eric.auger@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com> <Y2zE0zfnQ7mt740i@debian.me>
 <87v8nmhnkl.fsf@meer.lwn.net>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87v8nmhnkl.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/22 21:49, Jonathan Corbet wrote:
> So the report you're referring to is
> 
>   https://lore.kernel.org/linux-next/20221110182938.40ce2651@canb.auug.org.au/
> 

Ah, I forget to refer to that link!

> ?  If so, this change will not fix the problem.  That error:
> 
>> drivers/iommu/iommufd/device.c:1: warning: no structured comments found
>> drivers/iommu/iommufd/main.c:1: warning: no structured comments found
> 
> is caused by using .. kernel-doc:: directives to extract documentation
> from files where none exists - thus "no structured comments found".
> 

-ENOENT files :)

> The *real* problem, methinks, is that the directives are added in patch 4
> of the series, but the documentation doesn't show up until later.  So
> the real fix would be to simply move this patch down.  Or just not worry
> about it, since it all works out in the end and nobody will be bisecting
> a docs build.
> 
> Bagas, you are *again* misadvising people.  Please stop doing that!
> 

OK, thanks.

-- 
An old man doll... just what I always wanted! - Clara

