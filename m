Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83E51951C
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 11:33:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 006D21FB;
	Thu, 18 May 2023 04:34:16 -0700 (PDT)
Received: from [10.57.82.163] (unknown [10.57.82.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37EDD3F793;
	Thu, 18 May 2023 04:33:30 -0700 (PDT)
Message-ID: <359b01bc-e87a-9a50-c971-681e89985491@arm.com>
Date: Thu, 18 May 2023 12:33:25 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: arm-smmu-v3 sharing SID
Content-Language: en-GB
To: Peng Fan <peng.fan@nxp.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>,
 "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
 "will@kernel.org" <will@kernel.org>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <DU0PR04MB94172CB3F138AD39E9B6DEEF887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <DU0PR04MB94172CB3F138AD39E9B6DEEF887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-05-18 11:46, Peng Fan wrote:
> Hi all,
> 
> Current arm-smmu-v3 driver does not support sharing SID,
> If there are two devices sharing one SID, the smmu-v3 driver
> will report "stream x already in tree".
> 
> We have an SOC that using smmu-v3, only supports limited
> SIDs. From my understanding, the smmu-v3 hardware
> supports SID sharing, but linux driver not support that.

Ugh, we've always hoped that nobody would build such a thing, since 
SMMUv3 allows for plenty of stream IDs for any reasonable system (Arm's 
implementations support at least 24 bits), and aliasing at the StreamID 
level does rather compromise the usefulness.

> I would like know is it ok to add support for sharing SID?
> Something like to use common rb_add/find, not
> smmu-v3 driver local rb tree add/find.

Not sure what you're thinking there - the StreamID tree is still private 
to the SMMU instance either way, and the existing arm_smmu_find_master() 
function is ideal for arm_smmu_device_group() to detect aliasing devices 
and group them appropriately. Then you also need some way to skip 
updating STEs that have already been touched for a previous device in 
the group (basically generalising what arm_smmu_install_ste_for_dev() 
currently does for duplicate StreamIDs owned by one device).

I'm fairly confident in reasoning about this for basic .attach_dev 
purposes, since I did implement the equivalent for SMMUv2, but I'm not 
sure I even want to think about what it would mean for SVA, PASIDs and 
nesting...

Thanks,
Robin.
