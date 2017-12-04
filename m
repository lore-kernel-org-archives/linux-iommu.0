From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Invalidation in SMMU v3
Date: Mon, 4 Dec 2017 11:12:32 +0000
Message-ID: <3decf6d6-46d8-b306-9ef3-b1f975a99c02@arm.com>
References: <52a6fdbb-9a47-76c0-da59-89ac561b8ee3@gmail.com>
	<8fd78f56-43ed-e480-1c98-5d1162452674@arm.com>
	<e8effeac-bdfb-34dd-63e5-eb3fb08fd540@gmail.com>
	<c2c2c5b0-7533-632b-f69e-050f125bef06@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c2c2c5b0-7533-632b-f69e-050f125bef06-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: valmiki <valmikibow-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Valmiki,

On 03/12/17 13:56, valmiki wrote:
> Hi Jean,
> 
> In PASID flow arm_smmu_atc_inv_master_all is called where size and iova 
> of arm_smmu_atc_inv_to_cmd are zero and  no address is being filled in 
> struct arm_smmu_cmdq_ent->atc.addr.
> So how will smmu hardware know if there are any ats translations 
> requested or not ?
> How invalidation are carried out in PASID flow w.r.t address and size?

arm_smmu_atc_inv_master_all() is used to invalidate the whole address
space, for example when unbinding a process address space from the master.

The encoding is a bit special: when addr and size are 0,
arm_smmu_atc_inv_to_cmd() sets cmd->atc.size to 52, which according to the
SMMUv3 spec corresponds to a 2^64 byte span, meaning invalidate all. The
SMMU then converts this command into a PCIe ATC invalidation (with bits
62:12 all 1b and bit 63 = 0b, according to the ATS spec 2.3.2)

Smaller invalidations will go via arm_smmu_atc_inv_domain(), and
arm_smmu_atc_inv_to_cmd() will compute the appropriate range that covers
the requested address and size.

In more details, when a range is unmapped from a process (with munmap()
for example), the MMU notifier calls our invalidate_range() callback,
which calls arm_smmu_atc_inv_domain() with the right PASID. When a process
exits or unbind() is called, we use arm_smmu_atc_inv_master_all() with its
PASID.

Thanks,
Jean
