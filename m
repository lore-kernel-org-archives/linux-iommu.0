From: valmiki <valmikibow-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Invalidation in SMMU v3
Date: Sun, 3 Dec 2017 19:26:31 +0530
Message-ID: <c2c2c5b0-7533-632b-f69e-050f125bef06@gmail.com>
References: <52a6fdbb-9a47-76c0-da59-89ac561b8ee3@gmail.com>
	<8fd78f56-43ed-e480-1c98-5d1162452674@arm.com>
	<e8effeac-bdfb-34dd-63e5-eb3fb08fd540@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <e8effeac-bdfb-34dd-63e5-eb3fb08fd540-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

In PASID flow arm_smmu_atc_inv_master_all is called where size and iova 
of arm_smmu_atc_inv_to_cmd are zero and  no address is being filled in 
struct arm_smmu_cmdq_ent->atc.addr.
So how will smmu hardware know if there are any ats translations 
requested or not ?
How invalidation are carried out in PASID flow w.r.t address and size?


Regards,
Valmiki

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
