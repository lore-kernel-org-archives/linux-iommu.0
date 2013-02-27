From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 6/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU API
	implementation.
Date: Wed, 27 Feb 2013 11:56:08 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D3C2691@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
	<1361191939-21260-7-git-send-email-Varun.Sethi@freescale.com>
	<CALRxmdBBO2AoAnKSTNNTYhHZ9fitJKWWeZMUj1ObtFhsZS5iSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CALRxmdBBO2AoAnKSTNNTYhHZ9fitJKWWeZMUj1ObtFhsZS5iSw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Stuart Yoder [mailto:b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Wednesday, February 27, 2013 4:03 AM
> To: Sethi Varun-B16395
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wood Scott-B07421; Joerg Roedel; Yoder
> Stuart-B08248
> Subject: Re: [PATCH 6/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU
> API implementation.
> 
> Have not got through the entire file, but have a few comments...
> 
> +/*
> + * Set the PAACE type as primary and set the coherency required domain
> + * attribute
> + */
> +static void pamu_setup_default_xfer_to_host_ppaace(struct paace
> +*ppaace) {
> +       set_bf(ppaace->addr_bitfields, PAACE_AF_PT, PAACE_PT_PRIMARY);
> +
> +       set_bf(ppaace->domain_attr.to_host.coherency_required,
> PAACE_DA_HOST_CR,
> +              PAACE_M_COHERENCE_REQ);
> +}
> +
> +/*
> + * Set the PAACE type as secondary and set the coherency required
> +domain
> + * attribute.
> + */
> +static void pamu_setup_default_xfer_to_host_spaace(struct paace
> +*spaace) {
> +       set_bf(spaace->addr_bitfields, PAACE_AF_PT, PAACE_PT_SECONDARY);
> +       set_bf(spaace->domain_attr.to_host.coherency_required,
> PAACE_DA_HOST_CR,
> +              PAACE_M_COHERENCE_REQ);
> +}
> 
> Can we change the names of the above functions...   I know there is some
> history
> with the name, but "xfer_to_host" is confusing.
> 
> Maybe just call them:
> 
> pamu_init_paace()
> pamu_init_spaace()
> 
[Sethi Varun-B16395] ok, will change the function names.

> > +/**
> > + * pamu_config_spaace() - Sets up SPAACE entry for specified
> > +subwindow
> > + *
> > + * @liodn:  Logical IO device number
> > + * @subwin_cnt:  number of sub-windows associated with dma-window
> > + * @subwin_addr: starting address of subwindow
> > + * @subwin_size: size of subwindow
> > + * @omi: Operation mapping index
> > + * @rpn: real (true physical) page number
> > + * @snoopid: snoop id for hardware coherency -- if ~snoopid == 0 then
> > + *                       snoopid not defined
> > + * @stashid: cache stash id for associated cpu
> > + * @enable: enable/disable subwindow after reconfiguration
> > + * @prot: sub window permissions
> > + *
> > + * Returns 0 upon success else error code < 0 returned  */ int
> > +pamu_config_spaace(int liodn, u32 subwin_cnt, u32 subwin_addr,
> > +                      phys_addr_t subwin_size, u32 omi, unsigned long
> rpn,
> > +                      u32 snoopid, u32 stashid, int enable, int prot)
> > +{
> > +       struct paace *paace;
> > +
> > +       /* setup sub-windows */
> > +       if (!subwin_cnt) {
> > +               pr_err("Invalid subwindow count\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       paace = pamu_get_ppaace(liodn);
> > +       if (subwin_addr > 0 && subwin_addr < subwin_cnt && paace) {
> 
> Why is the comparison subwin_addr < subwin_cnt?   Seems wrong...
> 
[Sethi Varun-B16395] It's actually the subwindow index. I will rename the variable.

> > +               paace = pamu_get_spaace(paace, subwin_addr - 1);
> > +
> > +               if (paace && !(paace->addr_bitfields & PAACE_V_VALID))
> {
> > +                       pamu_setup_default_xfer_to_host_spaace(paace);
> > +                       set_bf(paace->addr_bitfields, SPAACE_AF_LIODN,
> liodn);
> > +               }
> > +       }
> > +
> > +       if (!paace) {
> > +               pr_err("Invalid liodn entry\n");
> > +               return -ENOENT;
> > +       }
> > +
> > +       if (!enable && prot == PAACE_AP_PERMS_DENIED) {
> > +               if (subwin_addr > 0)
> > +                       set_bf(paace->addr_bitfields, PAACE_AF_V,
> > +                                PAACE_V_INVALID);
> > +               else
> > +                       set_bf(paace->addr_bitfields, PAACE_AF_AP,
> > +                                prot);
> > +               mb();
> > +               return 0;
> > +       }
> 
> Can you add a comment to the above if statement...when is this function
> called with PAACE_AP_PERMS_DENIED?
> 
[Sethi Varun-B16395] Actually, this piece of code is redundant in case of the window based API. I will remove this. PAACE_AP_PERMS_DENIED is primarily used for disabling the primary subwindow.

-Varun
