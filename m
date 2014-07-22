From: leizhen <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v3 00/13] Add support for Hisilicon SMMU architecture
Date: Tue, 22 Jul 2014 11:54:45 +0800
Message-ID: <53CDE085.9090709@huawei.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
 <53CC7234.4080703@huawei.com> <20140721093951.GC16122@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140721093951.GC16122@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: "huxinwei@huawei.com" <huxinwei@huawei.com>, iommu@lists.linux-foundation.org, Lizefan <lizefan@huawei.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 2014/7/21 17:39, Will Deacon wrote:
> [re-adding the lists]
> 
> On Mon, Jul 21, 2014 at 02:51:48AM +0100, leizhen wrote:
>> Hi, Will
> 
> Hello,
> 
>> I have sent this patch a week ago. I saw that you and Mitchel Humpherys had
>> sent some patches which will impact my code. I list below:
>> iommu/arm-smmu: remove support for chained SMMUs
>> iommu/arm-smmu: fix some checkpatch issues
> 
> There's also all of the development work I'm doing for VFIO and the page-table
> rework that Varun's working on, so these patches are going to be difficult
> to merge if we ever get to that point. I think Mitchel and Olav are also
> busy trying to get their SMMU supported by the driver. Given that they've
> actually bothered to follow the architecture, I don't see why they should
> be messed about by your patches causing conflicts all over the place.
> 
>> I can ajust my patch because of above. I known this patch is not follow what
>> you suggested before(fit into arm-smmu.c). But I found when we need to support
>> ARM SMMUv3, maybe we should do like this. I really want to know whether or not
>> you agree the software framework in this patch? Or what do you think about
>> SMMUv3?
> 
> The only code I foresee sharing between SMMUv2 and SMMUv3 is the page-table
> creation code. The two architectures are significantly different, so I don't
> think your split really helps us there. For example, you've left the probing
> code in smmu-base.c. Of course, if HiSilicon follow the SMMUv3 spec as well
> they did with SMMUv2, then your point is moot anyway and we may as well go
> home.
> 
>>> I tried to merge hisi-smmu driver into arm-smmu.c, but it looks impossible.
>>> The biggest problem is that too many registers are diffrent: the base address,
>>> the field definition, or present only on one side. And if I use #if, hisi-smmu
>>> and arm-smmu can not coexist in one binary file. Almost need 20 #if.
> 
> I don't think #ifdefs are necessarily the right way to go. There are IMPDEF
> parts of a compliant SMMU (e.g. power management), so having a new compatible
> string and a set of internal ops which can be overridden by a particular
> implementation wouldn't be the end of the world and would be far less
> invasive.
> 
> The problem you have is that your SMMU isn't architecturally compliant, so
> you'll end up having to restructure parts of the driver so you can add
> internal hooks for operations that aren't actually IMPDEF. That's the part
> I'm worried about and we will have to draw the line somewhere, especially
> when other people are trying to work with this code for compliant
> implementations.
> 
> So, NAK to your current approach. You need to try something like I said
> above and, if you want to spit the file up, start with the page-table code.
> 
> Will
> 
> .
> 

OK. We have decided to discard current SMMU hardware design, and will
completely follow the SMMUv3 specification.
