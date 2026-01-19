Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8298361DDB;
	Mon, 19 Jan 2026 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828030; cv=none; b=eT+BW6/+IvcWsgZURTEWR711DxIhmrgfaBrgCFM3OZ7FkA2/fquxLH/mPYKueuxp/fxWlQtJ2y4oSfuYd6Y2hPcao9tADjFPljDGiJUQR3US+bPQHrrVgQekHDxFaemdZT4CcZz8vWf7tm/D3xNs78+4a8Ln1l/1j9A420Uee6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828030; c=relaxed/simple;
	bh=cGzPxUmaEhFMDDElzlC+0Cv5UBY7+PeNviT+AavSgPM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=XCWn67Z4MqZnCdmnYwP5ReiI+h7QGcJWzgY4s6M8Gzh8Y+0qR0w6k7aZ3RJwYI62wuMotFTSN9N28Fu5OUjzszdake8Vj1dbL5cK+/MQGqdqMmypXlrPPNH4eNOtcRoyg/Bo83yITRPEGt/q2xj9NKicb71Ab8wa4oTbRKmGX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from [192.168.0.66] ([88.171.60.104]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M3lLh-1vhXll1nPv-00BvaZ; Mon, 19 Jan 2026 13:53:02 +0100
Message-ID: <154d0ccb-00d8-4e7b-ab6e-c798c86c5e96@green-communications.fr>
Date: Mon, 19 Jan 2026 13:53:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rob Herring (Arm)"
 <robh@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, regressions@lists.linux.dev
References: <a1d926f0-4cb5-4877-a4df-617902648d80@green-communications.fr>
 <eb94b379-6e0b-4beb-aaa7-413a4e7f04b9@green-communications.fr>
 <3780eb61-68e2-42ce-939e-7458cd3a63cb@green-communications.fr>
 <4da29d46-9a80-4ec4-b6b8-6c9457eed481@arm.com>
Content-Language: en-US
From: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Autocrypt: addr=Nicolas.Cavallari@green-communications.fr; keydata=
 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
Subject: Re: [REGRESSION] Re: imx8 PCI regression since "iommu: Get DT/ACPI
 parsing into the proper probe path"
In-Reply-To: <4da29d46-9a80-4ec4-b6b8-6c9457eed481@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qvKrgniDhCDttoq4hx/KpwZ7wvT16Hg+QjDEhqguqFoZvTWbYYU
 TAdm6qt5OYVkrkzIV5BNU900bXM0nA2ibuHysJmVsMFcS3Dg0a4BXevHAaml5stE7+brjh3
 G4BzfnZqu694rkvzCdqJNoOeJi8QMlhuL9ygtzBVxeOTgA/J20A8OqLub9ESDr49En8OwaK
 +/xqqWg7onaVG+Ll/CRpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:slaf2Cm0ugI=;1lbBD/9BPW6h8W0LswDP70N/23k
 9KzQyb0RF3d9BtFCvZkveytzOtwxgZu+faJK8+yLZrIqtyACeQxC5Kf8P5qCmWgCemptaEla1
 CFAzBa2qBTBNI9RrnRhhjhUlOJk9HHqx3tFkAePb17Xwyd1z2pdqKjvz+eLDto00xwtrp3hY6
 zqGmOmh7HOMbuXX3YytGC8oXTXhV52EpBFU3coNVjiB29UrEjz1lD9fYM4z2y+gHW9Vc3YBsl
 AZ5M1wrHRWfHGrSpL2zZj4ihOAKaVBgWo8rnxSQfFKSilxFf7wU/1sW+zZt0CviZX1Ipx+m9v
 lCfRvm/iX4u3peyElCHT3gMuPuEtszwnMPN2K1DrLBID/cJPQv0YIDQaz+GT75G5WLGYLcloZ
 VykeChFFsdZ7aXGsWnsQthUyzb6QdTDcuK+t3CmT5NyrHURhYr/MuY8EtLGQQyOLmZ2zgMIBL
 pAmyB7PF7aDn0vcIa3QuiysnGOmvvqXHqI2eTu3pCQSf1k8+B3DOVnMC/ZDaddIWGuZ51NDuZ
 ZKcUpF+7n5CfWr5VC1nRlg5RGWm8s8H3OV4r9l2Q0f/Otjm0PCY9Lj7sVG+dyZvKnK7qJWiB3
 hUHwkDyLBor9F8bIi+IWSQY5LyhOBQvv6p82Okx0L7+q4yaf5QSDjAixqiIHkA0p5O7mt5RgH
 E+JbGiUvP+xYH1QVG1QmW12a2XAKupP1Pe+5sebtXYsGXcoYjj8LoMwHkeGNN/S0sd6DZV4b8
 32M88P/v3hxjILEmtIPm89ypY62qeWNfE6nwddNT+5KEYg6cjlWLOPitKHdlYrOQm+xsfjt/2
 WtEIBjrRblR3ffGnmBhBG9LDZtW4tpunIGswkULTSQ/fvdAZ9ePaL/8hYTdCQ8AcZzShilW3K
 AQeGULXc4boKh1bCStdR0dqHO6lU+hnEU5jbzaOnFFNBgNecleougOXnTI1R3bJm4G6uGDoSD
 /WGhj3dP5E7TkMeD0z4WXFMAwmbimYD5YcvrADGZooUkxZKqPDD2Wzuli1J0DQGupxR7mZJU+
 x+Dp+coJ51VHyL9JLG1HVFLgFR+XV0qIex7kPZwQvuFUWw7JsOKXiA7fxxoIuW5NYEGPiiZqr
 jfaMcb8jytL12GpxP/tzIqpClpahZYNRH6EjwguY1GaiwH9RxwhsuKOVgAsjvcRyyEhNdQ5GL
 REcDSQ/yBKOhwjTijzwmx0HXPBI8BeH+Piu3K38CQQgQ1A6Uep1dv6KJNT5B3X5R7MTZbXd9d
 4GzuXnuxf7mWHLqccTKqhAXVpzWMnfMxXq1gq92mJVWjj0Q+jSvXXo8eaXqOAs65bGmnOHtcs
 pda88iFqLsxWKtGINDdaRDD4R7ZMh5etZlkr8YybAPKZDWAMa8wRoWYXF3r/gyCG0vimTvGYD
 4A+QPdd538xCJpaZ+CDeBOv5VqQ6chIEqhEF8cKnapsJscalDlJiUUqZqpTWD+rok/IWBgiLS
 ViMiaJS9FQ5ddf3M94YY+TZWuI4V6N+NOJKXvU2qH/LZhPZZGK+LR2qqiZ2/LuupHQ+sxMRnL
 YVgMF4Q/2Lv2lDOCRE5xzuM9u9h8kMf+nwYEf67VWezxVDUjjWA21a9YzNWOG9Le1PibVxiaU
 jQUn104emVF2YpKNZxyoSWV+BHY1Evqn7mMPV640chSkgk4KBxTlzRzBlvp/11XS5ChmsLoUk
 AYK0d9O+UFwjtT+QDBBFBXacRy1/GFefOE+kU8QkkOjcq/oWUNSzjv6YaNqq4oD/XgbkHdnMs
 Yhh4f3pdrbU7i6qOQVbjEyLNS4R2DMqClRFEvdDtFYbZYW5rsD793HwQ=

Le 16/01/2026 à 18:24, Robin Murphy a écrit :
> On 2026-01-16 4:52 pm, Nicolas Cavallari wrote:
>> +cc regressions ML
>>
>> Le 13/01/2026 à 10:17, Nicolas Cavallari a écrit :
>>> +cc patch author & reviewers
>>>
>>> On 1/9/26 17:22, Nicolas Cavallari wrote:
>>>> When upgrading from 6.12 to a 6.18 kernel, I noticed that a PCI
>>>> Ethernet adapter (Microchip LAN7430) would hang under load and not
>>>> recover.  When that happens, some of its registers indicate it is
>>>> failing to do DMA reads, so cannot reclaim entries on its ring buffer.
>>>>
>>>> I bisected the problem into this commit:
>>>>
>>>> commit bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c
>>>> Author: Robin Murphy <robin.murphy@arm.com>
>>>> Date:   Fri Feb 28 15:46:33 2025 +0000
>>>>
>>>>        iommu: Get DT/ACPI parsing into the proper probe path
>>>>
>>>> The problem still exists on 6.19-rc1, on pci/next (29a77b4897f1) and on
>>>> iommu/master (360e85353769) trees.  Reverting the commit fixes the
>>>> issue.
>>
>> The problem persists on 6.19-rc5
>>
>>>> The system is a Gateworks GW7200, which is a i.MX 8 Mini connected to a
>>>> Pericom
>>>> PI7C9X2G404 4-port switch connected to the LAN7430 chip.
>>>>
>>>> -[0000:00]---00.0-[01-ff]----00.0-[02-05]--+-01.0-[03]----00.0
>>>>                                               +-02.0-[04]--
>>>>                                               \-03.0-[05]----00.0
>>>>
>>>> The problem only occurs when there is at least another PCI device in use
>>>> on the
>>>> switch.  It does not happen if the LAN7430 is the only PCI device, or if
>>>> the
>>>> other devices are not actively used.  For example i can reproduce it
>>>> with an
>>>> ath9k wireless network adapter when it is up and running, but not when
>>>> it is
>>>> down or its driver is not loaded.
>>>>
>>>> I suspect that other PCI devices have similar issues, but the LAN7430 is
>>>> the
>>>> easiest one to diagnose, as it hangs within seconds with an iperf3 --
>>>> bidir -u
>>>> -b 200M and its register map are public.
>>>>
>>>> I couldn't find an way to dump the PCI address translation mapping from
>>>> userspace.
>>>> I would be happy to provide more information or test patches.
>>
>> I debugged it further, it seems to be mostly a PCI issue since the
>> system does not actually have an IOMMU.
> 
> Indeed, I was figuring this had to be another case of a switch with
> wonky ACS - do Mani's patches adjusting ACS enablement make any difference?
> 
> https://lore.kernel.org/all/20260102-pci_acs-v3-1-72280b94d288@oss.qualcomm.com/

With this series, ACS is still enabled and eth1 is still failing under load.

> Although in this case I guess the issue is arguably more that we're
> requesting ACS at all, before we know that there's actually an IOMMU
> present to warrant it. Clearly the best option would be to figure out if
> the switch behaviour itself can be fixed somehow, but perhaps something
> like this might help paper over the issue for now (but I'd have to test
> it to make sure it doesn't break IOMMUs again...)
> 
> ----->8-----
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 6b989a62def2..837cc0b5ace4 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -141,10 +141,12 @@ int of_iommu_configure(struct device *dev, struct
> device_node *master_np,
>    			.np = master_np,
>    		};
> 
> -		pci_request_acs();
>    		err = pci_for_each_dma_alias(to_pci_dev(dev),
>    					     of_pci_iommu_init, &info);
> -		of_pci_check_device_ats(dev, master_np);
> +		if (!err) {
> +			pci_request_acs();
> +			of_pci_check_device_ats(dev, master_np);
> +		}
>    	} else {
>    		err = of_iommu_configure_device(master_np, dev, id);
>    	}
> -----8<-----

With this, ACS is indeed disabled and eth1 no longer fails under load, but I 
have also identified an errata on the PCIe switch that causes ACS to fail. I've 
sent another message in this thread.
