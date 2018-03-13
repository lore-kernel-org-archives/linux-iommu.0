From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 5/5] iommu/amd - Add a debugfs entry to specify a IOMMU
	device table entry
Date: Tue, 13 Mar 2018 22:56:30 +0200
Message-ID: <CAHp75VcuYamhrEu=B1zeFpz6s1vGfZaMyonYK6p_Y_EJF4=4Ng@mail.gmail.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
	<152055669123.63229.1692099069085978884.stgit@sosxen2.amd.com>
	<CAHp75Vfc+JTjU2P0GCedVFcHYniXoVcmRC3n4cFsLMr9sx6eyA@mail.gmail.com>
	<3969f155-c3bf-44c5-d056-825e71d42152@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3969f155-c3bf-44c5-d056-825e71d42152-5C7GfCeVMHo@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 13, 2018 at 8:54 PM, Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org> wrote:
> On 03/13/2018 12:20 PM, Andy Shevchenko wrote:

>>> +       } else if (obuf[0] == '0' && obuf[1] == 'x') {
>>> +               n = sscanf(obuf, "%x", &amd_iommu_devid);
>>> +       } else {
>>> +               n = sscanf(obuf, "%d", &amd_iommu_devid);
>>> +       }

>> kstrtoint() ?

> I see various mechanisms for this sort of thing, and simply chose one.
> Am happy to use whatever is preferred.

sscanf() has an enormous overhead for cases like this.

simple

ret = kstrtoint();
if (ret)
 ... do error handling ...


-- 
With Best Regards,
Andy Shevchenko
