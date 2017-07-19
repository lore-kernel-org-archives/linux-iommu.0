From: Anup Patel via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 0/5] FlexRM support in VFIO platform
Date: Wed, 19 Jul 2017 16:47:09 +0530
Message-ID: <CAALAos_YTVRu_u8DycSXPgniGru20+fS6wfUskpV5uLRsazcNw@mail.gmail.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
	<0dc860ed-a40c-1bfd-f584-225807edb25b@arm.com>
Reply-To: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <0dc860ed-a40c-1bfd-f584-225807edb25b-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 19, 2017 at 4:27 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 19/07/17 10:33, Anup Patel wrote:
>> This patchset primarily adds Broadcom FlexRM reset module for
>> VFIO platform driver. We also have minor improvments in IOMMU
>> and VFIO driver to allow VFIO no-IOMMU mode access to FlexRM.
>
> I'm struggling to understand the IOMMU changes here - what's the
> FlexRM's hardware relationship with the IOMMU, and how is it different
> from any other device? Furthermore, if there *is* a relevant IOMMU
> present, why would no-IOMMU mode need to be involved at all?

We want to have FlexRM device accessible from user-space
using VFIO platform with and without IOMMU.

Currently, if IOMMU ops are available for platform bus then
I cannot access FlexRM device using VFIO no-IOMMU mode.

Since, SMMU can bypass transactions which do not match
any SMRs, we should allow no-IOMMU mode for devices
when IOMMU group is not available.

Regards,
Anup
