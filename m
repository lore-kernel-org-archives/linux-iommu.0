From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH V3] iommu/amd: Add logic to decode AMD IOMMU event flag
Date: Mon, 8 Apr 2013 16:50:03 +0200
Message-ID: <20130408145003.GC4723@pd.tnic>
References: <1364947610-3327-1-git-send-email-suravee.suthikulpanit@amd.com>
	<02D2024799561B48A732D1A51CB969E81959AF3E@sausexdag04.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <02D2024799561B48A732D1A51CB969E81959AF3E-Vo+W8YXarrhLxsqq04mzcUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 08, 2013 at 02:33:32PM +0000, Suthikulpanit, Suravee wrote:
> Joerg,
> 
> Do you have any more feedback about this patch?
> 
> Thanks,
> 
> Suravee
> ________________________________________
> From: suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org [suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org]
> Sent: Tuesday, April 02, 2013 7:06 PM
> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Suthikulpanit, Suravee
> Subject: [PATCH V3] iommu/amd: Add logic to decode AMD IOMMU event flag
> 
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

Independent from Joerg's feedback on this, I have only one question:
you're not seriously considering on dumping this "Note:..." line above
on *every* IO-PF, right?

I very positively assume that people who stare at that output should, as
a first prerequisite, know where to find those fields' descriptions. :-)

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
