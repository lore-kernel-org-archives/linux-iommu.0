From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Assign default IOMMU when there is only one
 IOMMU
Date: Wed, 16 Dec 2015 21:17:57 -0600
Message-ID: <56722965.2010806@amd.com>
References: <1449874478-31770-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20151214150805.GE11292@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151214150805.GE11292@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On 12/14/2015 9:08 AM, Joerg Roedel wrote:
> On Fri, Dec 11, 2015 at 04:54:38PM -0600, Suravee Suthikulpanit wrote:
>> Current driver makes assumption that device with devid zero is always
>> included in the range of devices to be managed by IOMMU. However,
>> certain FW does not include devid zero in IVRS table.
>> This has caused IOMMU perf driver to fail to initialize.
>
> Hmm, this is a firmware bug. Is this bug seen in any systems that are
> for sale?
>
>> This patch implements a workaround for this case by always assign
>> devid zero to be handled by the first IOMMU.
>
> Otherwise its better to fix the firmware than to add workarounds.
>
>
> 	Joerg
>

Please ignore this patch. There are more stuff that I am planning to 
fix, and I am reworking them into V2. I'll send this out soon.

Suravee
