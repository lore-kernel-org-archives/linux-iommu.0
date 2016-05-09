From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 0/4] Code refine for Intel IOMMU
Date: Mon, 9 May 2016 13:24:02 +0200
Message-ID: <20160509112401.GC13275@8bytes.org>
References: <1460645710-22656-1-git-send-email-richard.weiyang@gmail.com>
	<20160508132253.GA2708@vultr.guest>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160508132253.GA2708-yrDqe6+Pica9sAcnBtTtJQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sun, May 08, 2016 at 01:22:53PM +0000, Wei Yang wrote:
> >Wei Yang (4):
> >  iommu/vt-d: replace *hdr with {drhd/atsr}[0] in struct
> >    dmar_{drhd/atsr}_unit
> >  iommu/vt-d: use zero-sized array in DMAR related ACPI structures
> >  iommu/vt-d: check Register Base Address at the beginning of
> >    dmar_parse_one_drhd()
> >  iommu/vt-d: refine dmar_acpi_dev_scope_init() with
> >    dmar_walk_dmar_table()

Okay, I've ignored this so far as I don't see where you are going with
this refactoring. The patches as-is don't make much sense to me other
than creating conflicts with other vt-d driver changes.



	Joerg
