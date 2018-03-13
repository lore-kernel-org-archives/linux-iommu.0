From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 5/5] iommu/amd - Add a debugfs entry to specify a IOMMU
	device table entry
Date: Tue, 13 Mar 2018 19:20:42 +0200
Message-ID: <CAHp75Vfc+JTjU2P0GCedVFcHYniXoVcmRC3n4cFsLMr9sx6eyA@mail.gmail.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
	<152055669123.63229.1692099069085978884.stgit@sosxen2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <152055669123.63229.1692099069085978884.stgit-tq90VzyE+wXkLsZ8J5Uweg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 9, 2018 at 2:51 AM, Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org> wrote:
> Initially (at boot) the device table values dumped are all of the
> active devices.  Add a devid debugfs file to allow the user to select a
> single device table entry to dump (active or not). Let any devid value
> greater than the maximum allowable PCI ID (0xFFFF) restore the
> behavior to that effective at boot.

> +               oboff += OSCNPRINTF("%02x:%02x:%x (%u / %04x)\n",
> +                                   PCI_BUS_NUM(amd_iommu_devid),
> +                                   PCI_SLOT(amd_iommu_devid),
> +                                   PCI_FUNC(amd_iommu_devid),

Perhaps at some point we will have an extension to %p to print PCI BDFs.

> +       if (strnchr(obuf, OBUFLEN, ':'))
> +       {

Style

> +       } else if (obuf[0] == '0' && obuf[1] == 'x') {
> +               n = sscanf(obuf, "%x", &amd_iommu_devid);
> +       } else {
> +               n = sscanf(obuf, "%d", &amd_iommu_devid);
> +       }

kstrtoint() ?

-- 
With Best Regards,
Andy Shevchenko
