From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] iommu/amd: Fix interrupt remapping when disable
	guest_mode
Date: Thu, 29 Jun 2017 10:27:35 +0700
Message-ID: <a32b28fb-da5b-9b61-c26f-809fed23085f@amd.com>
References: <1498469284-85652-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20170628124447.GA28603@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170628124447.GA28603-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 6/28/17 19:44, Joerg Roedel wrote:
> On Mon, Jun 26, 2017 at 04:28:04AM -0500, Suravee Suthikulpanit wrote:
>> Pass-through devices to VM guest can get updated IRQ affinity
>> information via irq_set_affinity() when not running in guest mode.
>> Currently, AMD IOMMU driver in GA mode ignores the updated information
>> if the pass-through device is setup to use vAPIC regardless of guest_mode.
>> This could cause invalid interrupt remapping.
>>
>> Also, the guest_mode bit should be set and cleared only when
>> SVM updates posted-interrupt interrupt remapping information.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>> Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>
> Nervermind, I added this fixes line and applied the patch:
>
> 	Fixes: d98de49a53e48 ('iommu/amd: Enable vAPIC interrupt remapping mode by default'
>

Thanks,

Suravee
