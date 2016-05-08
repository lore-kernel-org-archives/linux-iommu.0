From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 0/4] Code refine for Intel IOMMU
Date: Sun, 8 May 2016 13:22:53 +0000
Message-ID: <20160508132253.GA2708@vultr.guest>
References: <1460645710-22656-1-git-send-email-richard.weiyang@gmail.com>
Reply-To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460645710-22656-1-git-send-email-richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

Ping~

On Thu, Apr 14, 2016 at 02:55:06PM +0000, Wei Yang wrote:
>These four patches try to refine the Intel IOMMU.                                                                                     
>                                                                                                                                      
>Patch 1/2 tries to make it more user friendly by add a zero-sized array in                                                            
>some dmar data structure.                                                                                                             
>Patch 3 move the ckeck of Register Base Address ahead to avoid cleanup when it                                                        
>is NULL.                                                                                                                              
>Patch 4 re-use dmar_walk_dmar_table() to make the code easy to understand.
>
>V4:
>  * add similar change for struct dmar_atsr_unit in patch 1
>  * add similar change for rmrr and atsr in patch 2
>
>V3:
>  * change hdr to drhd from type acpi_dmar_header to acpi_dmar_hardware_unit 
>  * add reason in changelog for the change in Patch 1
>
>V2:
>  * add patch 3 and 4
>
>Wei Yang (4):
>  iommu/vt-d: replace *hdr with {drhd/atsr}[0] in struct
>    dmar_{drhd/atsr}_unit
>  iommu/vt-d: use zero-sized array in DMAR related ACPI structures
>  iommu/vt-d: check Register Base Address at the beginning of
>    dmar_parse_one_drhd()
>  iommu/vt-d: refine dmar_acpi_dev_scope_init() with
>    dmar_walk_dmar_table()
>
> drivers/iommu/dmar.c                |  129 +++++++++++++++++------------------
> drivers/iommu/intel-iommu.c         |   26 +++----
> drivers/iommu/intel_irq_remapping.c |   10 ++-
> include/acpi/actbl2.h               |   33 +++++----
> include/linux/dmar.h                |    3 +-
> 5 files changed, 102 insertions(+), 99 deletions(-)
>
>-- 
>1.7.9.5

-- 
Wei Yang
Help you, Help me
