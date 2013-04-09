From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3] iommu/amd: Add logic to decode AMD IOMMU event flag
Date: Tue, 9 Apr 2013 11:41:32 +0200
Message-ID: <20130409094132.GD6858@8bytes.org>
References: <1364947610-3327-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1364947610-3327-1-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 02, 2013 at 07:06:50PM -0500, Suthikulpanit, Suravee wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> 
> Add logic to decode AMD IOMMU event flag based on information from AMD IOMMU specification.
> This should simplify debugging IOMMU errors.  Also, dump DTE information in additional cases.
> 
> This is an example:
> AMD-Vi: Event logged [IO_PAGE_FAULT device=51:00.0 domain=0x0000 address=0x0000000000000000 flags=0x0fff]
> AMD-Vi: Flags details: Guest NX=1 User Intr Present Write No-Perm Rsrv-Bit Translation
> AMD-Vi: Type of error: (0x7) 
> AMD-Vi: (Note: Please refer to AMD IOMMU specification for details.)
> AMD-Vi: DTE[0]: 6000003fa75e2403
> AMD-Vi: DTE[1]: 0000000000000014
> AMD-Vi: DTE[2]: 2000003fa5e09011
> AMD-Vi: DTE[3]: 0000000000000000

This example should look like this instead:

AMD-Vi: Event logged [IO_PAGE_FAULT device=51:00.0 domain=0x0000 address=0x0 flags: G NX US I P Wr Rsvd Tr]

by default. When the user passes amd_iommu=verbose on the cmd-line then
you can print additional information like "type of error" or the dump
the DTE.


	Joerg
