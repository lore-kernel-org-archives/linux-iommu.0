From: Shuah Khan <shuahkhan@gmail.com>
Subject: Re: [PATCH 12/16] iommu/amd: Add initialization routines for AMD
 interrupt remapping
Date: Mon, 1 Oct 2012 10:02:18 -0600
Message-ID: <CAKocOOOpN413i+yET-7-TSR6dHnkp5+EzDkaO7DmoCRnc-iMGQ@mail.gmail.com>
References: <1348835046-3262-1-git-send-email-joerg.roedel@amd.com>
	<1348835046-3262-13-git-send-email-joerg.roedel@amd.com>
	<CAKocOONojx7tvu6x+HV97Rae-KXA3hW65Ujmt2t7LCVs9oRpyw@mail.gmail.com>
	<20121001080541.GM4009@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121001080541.GM4009@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 1, 2012 at 2:05 AM, Joerg Roedel <joerg.roedel@amd.com> wrote:
> On Fri, Sep 28, 2012 at 05:18:18PM -0600, Shuah Khan wrote:
>> > +void amd_iommu_disable(void)
>> > +{
>> > +       amd_iommu_suspend();
>>
>> Is it safe to attempt to suspend when iommu is in suspend state? In
>> other words what happens if amd_iommu_disable() gets called when iommu
>> is already in suspend state?
>
> Yes, this is safe. It just trns a bit to 0 which is already 0.
>
Good.
>>> > +int amd_iommu_reenable(int mode)
>> > +{
>> > +       amd_iommu_resume();
>>
>> Same question as above. Safe to do a resume, when in resumed state?
>
> Safe too, it just writes values to the hardware which are already there.
> This was also proven by testing.
>

Thanks. Sounds good.

-- Shuah
