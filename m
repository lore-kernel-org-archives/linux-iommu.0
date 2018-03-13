From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 5/5] iommu/amd - Add a debugfs entry to specify a IOMMU
	device table entry
Date: Tue, 13 Mar 2018 13:54:15 -0500
Message-ID: <3969f155-c3bf-44c5-d056-825e71d42152@amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
	<152055669123.63229.1692099069085978884.stgit@sosxen2.amd.com>
	<CAHp75Vfc+JTjU2P0GCedVFcHYniXoVcmRC3n4cFsLMr9sx6eyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAHp75Vfc+JTjU2P0GCedVFcHYniXoVcmRC3n4cFsLMr9sx6eyA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 03/13/2018 12:20 PM, Andy Shevchenko wrote:
> 
>> +               oboff += OSCNPRINTF("%02x:%02x:%x (%u / %04x)\n",
>> +                                   PCI_BUS_NUM(amd_iommu_devid),
>> +                                   PCI_SLOT(amd_iommu_devid),
>> +                                   PCI_FUNC(amd_iommu_devid),
> 
> Perhaps at some point we will have an extension to %p to print PCI BDFs.

But until then....  ;-)

>> +       if (strnchr(obuf, OBUFLEN, ':'))
>> +       {
> 
> Style

D'oh!

>> +       } else if (obuf[0] == '0' && obuf[1] == 'x') {
>> +               n = sscanf(obuf, "%x", &amd_iommu_devid);
>> +       } else {
>> +               n = sscanf(obuf, "%d", &amd_iommu_devid);
>> +       }
> 
> kstrtoint() ?

I see various mechanisms for this sort of thing, and simply chose one.
Am happy to use whatever is preferred.
