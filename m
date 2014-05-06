From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Take mmap_sem when calling get_user_pages
Date: Tue, 6 May 2014 14:27:08 -0500
Message-ID: <5369378C.9010902@amd.com>
References: <1398724066-3730-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140506181438.GD12376@8bytes.org> <536933E9.6040404@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <536933E9.6040404@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kim.naru@amd.com, jay.cornwall@amd.com
List-Id: iommu@lists.linux-foundation.org

On 5/6/2014 2:11 PM, Suravee Suthikulanit wrote:
> On 5/6/2014 1:14 PM, Joerg Roedel wrote:
>> On Mon, Apr 28, 2014 at 05:27:46PM -0500, Suthikulpanit, Suravee wrote:
>>> From: Jay Cornwall <jay.cornwall@amd.com>
>>>
>>> get_user_pages requires caller to hold a read lock on mmap_sem.
>>
>> Right, but can't we just switch to get_user_pages_fast instead?
>>
>>
>>     Joerg
>>
>
> You're right. I think it can. Let me spin out another patch.
>
> Suravee
>

Actually, we would have to provide the pointer to task_struct for the 
corresponding PASID which is not necessary "current".  So I take it 
back. I don't think we can use _fast.

Suravee
