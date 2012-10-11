From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [git pull] IOMMU Updates for v3.7-rc1
Date: Thu, 11 Oct 2012 11:32:39 +0200
Message-ID: <20121011093239.GA2619@amd.com>
References: <20121005152312.GA4649@8bytes.org>
	<20121009224532.1e515664@ado-amd-gentoo.moore.slainvet.net>
	<20121010073022.GB16151@8bytes.org>
	<20121010095823.140fdd98@ado-amd-gentoo.moore.slainvet.net>
	<20121010133249.GC16151@8bytes.org>
	<20121010201131.091d5a1f@ado-amd-gentoo.moore.slainvet.net>
	<20121010230231.2fb3c3b9@ado-amd-gentoo.moore.slainvet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121010230231.2fb3c3b9-IjT0q3EH84DI7ueSY2wKCeWwSe/Luo9VmGrBRn/+eNheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Oakley <andrew-WCNZvuCk18ErewFq2K+F1F6hYfS7NtTn@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 10, 2012 at 11:02:31PM +0100, Andrew Oakley wrote:
> On Wed, 10 Oct 2012 20:11:31 +0100
> Andrew Oakley <andrew-WCNZvuCk18ErewFq2K+F1F6hYfS7NtTn@public.gmane.org> wrote:

> I'm not sure if the fix I've got is safe or if it's really a good idea
> to enable interrupt remapping with a broken BIOS.

Sadly it is not. Your patch works for your particular case but is not
generally applicable. There are indeed systems with 2 or more IOAPICs
and they all use different device-ids.

So, typically, there is one IOAPIC per SB, like in your case. But on
RD890 the chipset NB also includes an IOAPIC (which uses
device-id 00:00.1). This IOAPIC exists on your system too but is
disabled by the BIOS because the board does not use it.

So, in the end, device-id 00:00.1 might also be correct and the IVRS
entry could refer to the NB IOAPIC. We don't have any reliable
indication which IOAPIC is described in the IVRS table.

Cheer,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
