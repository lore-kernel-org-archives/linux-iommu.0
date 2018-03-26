From: Gary R Hook <ghook@amd.com>
Subject: Re: [PATCH v3 0/5] Add debugfs info for the AMD IOMMU
Date: Mon, 26 Mar 2018 18:33:41 -0500
Message-ID: <29b998bf-c942-39e3-0e78-f1505492ac4b@amd.com>
References: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
 <20180315135838.GB5259@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180315135838.GB5259@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 03/15/2018 08:58 AM, Joerg Roedel wrote:
> On Wed, Mar 14, 2018 at 06:04:44PM -0500, Gary R Hook wrote:
>> Gary R Hook (5):
>>        iommu/amd - Add debugfs support
>>        iommu/amd - Add a 'verbose' switch for IOMMU debugfs
>>        iommu/amd - Add a README variable for the IOMMU debugfs
>>        iommu/amd - Expose the active IOMMU device table entries
>>        iommu/amd - Add a debugfs entry to specify a IOMMU device table entry
> 
> Same problem here as with the Intel patches, I don't think it's a good
> idea to reveal internal iommu data structures to user-space in this way.

I'm afraid I'm not following the line of thought here. AFAIK, if we 
restrict access of any debugfs info to root, then only root can see any 
of that information. If root is compromised, the whole system is 
compromised. Which seems to me to make all of debugfs suspect from a 
security perspective. Therefore, I'm likely not understanding the 
security concerns as they relate specifically to the IOMMU.

As for stability, you mention on the Intel IOMMU thread issues 
surrounding kABI, which I appreciate. But I'm exposing well-documented 
device structures in my patches, not kernel structures. There's nothing 
there that is going to change underneath me without my knowledge, if 
ever (I vote for never). And I'm likely ignorant about policy nuances 
surrounding the kernel ABI.

> I've debugged iommu issues for around 10 years now and never had the
> need for an interface that reveals those internals. How exactly are you
> planning to use this information?

Well, I've already had to dig into the DTEs and page tables for a couple 
of reasons (both debug and development), and it made life easier (for 
me) to make the live data available this way. Then I thought that others 
might be interested as well. Admittedly, I could be wrong.

Finally, I'm no guru, and likely am unaware of other techniques in which 
I should develop skills. I'm always open to input.
