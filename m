From: Valentine Sinitsyn <valentine.sinitsyn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: IVDB DTE_ALL Settings
Date: Wed, 05 Aug 2015 14:53:14 +0500
Message-ID: <55C1DD0A.4060601@gmail.com>
References: <20150804025745.GA4128@debian.debian>
	<20150804165619.GP14980@8bytes.org> <55C0F0E9.6030902@gmail.com>
	<20150805094836.GR14980@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150805094836.GR14980-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: David Kiarie <davidkiarie4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 05.08.2015 14:48, Joerg Roedel wrote:
> On Tue, Aug 04, 2015 at 10:05:45PM +0500, Valentine Sinitsyn wrote:
>> Not directly related to the issue David discovered, but as we
>> discuss IVRS handling: the specification says that ACPI tables data
>> overrides what's in hardware registers (Sect. 5). To the best of my
>> understanding, this means e.g. I should take HATS value not from EFR
>> but from IVHD Type 10 block. However, amd_iommu driver code checks
>> for features directly - for what reason? I'm not suggesting this is
>> a bug, but rather asking your opinion here.
>
> In my experience the hardware is more trustable than the ACPI table. We
> had several issues with broken BIOSes that screw up the IVRS ACPI table,
> so my trust in the values there is limited.
Makes sense. Thank you for sharing.

Valentine
