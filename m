From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/3] iommu/amd: Add logic to decode AMD IOMMU event flag
Date: Tue, 2 Apr 2013 16:40:37 +0200
Message-ID: <20130402144037.GE5488@pd.tnic>
References: <1364428283-2548-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20130402143335.GB15687@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130402143335.GB15687-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 02, 2013 at 04:33:36PM +0200, Joerg Roedel wrote:
> Hi Suravee,
> 
> On Wed, Mar 27, 2013 at 06:51:23PM -0500, suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org wrote:
> > From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> > 
> > Add logic to decode AMD IOMMU event flag based on information from AMD IOMMU specification.
> > This should simplify debugging IOMMU errors.  Also, dump DTE information in additional cases.
> 
> The patch in general makes sense to have, but I have a couple of
> comments.

While you guys are at it, can someone fix this too pls (ASUS board with
a PD on it).

[    0.220342] [Firmware Bug]: AMD-Vi: IOAPIC[9] not in IVRS table
[    0.220398] [Firmware Bug]: AMD-Vi: IOAPIC[10] not in IVRS table
[    0.220451] [Firmware Bug]: AMD-Vi: No southbridge IOAPIC found in IVRS table
[    0.220506] AMD-Vi: Disabling interrupt remapping due to BIOS Bug(s)

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
