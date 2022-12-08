Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7B33D3
	for <iommu@lists.linux.dev>; Thu,  8 Dec 2022 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670511725;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MArnQ2FGY7I6eGCOwCSHvUef/0UI3tkKf2FCn2qDX4=;
	b=F2aBfl0fp8lMTdf2Hr/2KgAepX4UoRFOx/cs4TqUWsRumJYxYnwOYooFkw7JmgHnvkniuI
	4mFXkTvDc1ZPdm6kyJIyOFEfr3o2VxkgIiFrd7WZfHfvltvhfG3fbr9NJzqTFWyqwLGLdz
	KXrIKrkVEZLBpAieDa3RT7lLmgiFNOg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-y6-wsPAyPMO5WhiunyGeGw-1; Thu, 08 Dec 2022 10:02:04 -0500
X-MC-Unique: y6-wsPAyPMO5WhiunyGeGw-1
Received: by mail-wm1-f72.google.com with SMTP id c187-20020a1c35c4000000b003cfee3c91cdso922343wma.6
        for <iommu@lists.linux.dev>; Thu, 08 Dec 2022 07:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MArnQ2FGY7I6eGCOwCSHvUef/0UI3tkKf2FCn2qDX4=;
        b=U0ZjqWx0OzCPsVmdXz4oxOjHU8LQ/kuBnbpCYL4CrUp52y8Hp7754cY2Lspsv5tfbZ
         raJOhO6OFYc0lRzirtCwqpP24jCYuayeOZkmkdYgmSczO4ttf9fEVja+9U+nIgjbvAL2
         WuVjh7HyNIrXabSvwQR+sT4N5BMik6FysHnpqqL/Ru4reUjUeJblMIPQnOvVqHu4zCgn
         y7StluOBBT/hR3492pbJ8apIsSXAVjSArEW4TcnpqFRdQctkDyPUrCktEfsg+I9J0plo
         MCVD4TcwSBZXwyduzJSI3UWNcmeCATxG5zzu0vOr0uAKYx3eQE1U8OrhMWGL29D8g4Qw
         S54A==
X-Gm-Message-State: ANoB5pl8XHPMulY758qpPbhPbMO1AMXLT29PNg6yROF3l4hR/N8SRiqW
	JKCJ/uOf6+U44fYMJcTudNScXUPzhF/gC6TJlvyEvKtcz4N09NdmobRO+c9wBlBJ3Fe0kvHgThZ
	1gjz9dn2x+vJ8bZA=
X-Received: by 2002:a05:600c:4e41:b0:3cf:8b72:e6fd with SMTP id e1-20020a05600c4e4100b003cf8b72e6fdmr2349146wmq.20.1670511722877;
        Thu, 08 Dec 2022 07:02:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6NiJ/EXIXfQww5rwswxD93hQeC1d6zOyySzhPcQ+OHdqdGTJrTSYUlE2gk/iasJh0+zAfg4g==
X-Received: by 2002:a05:600c:4e41:b0:3cf:8b72:e6fd with SMTP id e1-20020a05600c4e4100b003cf8b72e6fdmr2349116wmq.20.1670511722565;
        Thu, 08 Dec 2022 07:02:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c1c9800b003b47b80cec3sm6222874wms.42.2022.12.08.07.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 07:02:01 -0800 (PST)
Message-ID: <4ac2282a-2ff2-a80a-8c68-1ae25088ddef@redhat.com>
Date: Thu, 8 Dec 2022 16:02:00 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 3/3] iommufd: Change the order of MSI setup
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Binbin Wu <binbin.wu@linux.intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Lixiao Yang <lixiao.yang@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <3-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
 <148ee0ee-769e-201f-f918-5c3705225aeb@redhat.com>
 <Y5H2Qmz2bCXYHLA1@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Y5H2Qmz2bCXYHLA1@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 12/8/22 15:35, Jason Gunthorpe wrote:
> On Thu, Dec 08, 2022 at 03:18:49PM +0100, Eric Auger wrote:
>>> -	dev_warn(
>>> -		idev->dev,
>>> -		"MSI interrupt window cannot be isolated by the IOMMU, this platform is insecure. Use the \"allow_unsafe_interrupts\" module parameter to override\n");
>>> +		dev_warn(
>>> +			idev->dev,
>>> +			"MSI interrupt window cannot be isolated by the IOMMU, this platform is insecure. Use the \"allow_unsafe_interrupts\" module parameter to override\n");
>> I really prefer the legacy VFIO warning message: "No interrupt remapping
>> support.  Use ...". IRQ remapping is the feature that is actually
>> checked. MSI interrupt window sounds confusing: is it the MSI doorbell
>> or the range of addresses that correspond to MSI addresses.
> Well, that is true for x86 processors, but it is not what it is
> called on ARM. I wanted something more neutral, but am not fussed
> about it.
>
> And I suppose "by the IOMMU" is not really acurate either.
>
> How about
>
> "MSI interrupts are not secure, they cannot be isolated by the
> platform. Check that platform features like interrupt remapping are
> enabled. Use the \"allow_unsafe_interrupts\" module parameter to override\n"

yep sounds OK

Thanks

Eric
>
> ?
>
> Thanks,
> Jason
>

