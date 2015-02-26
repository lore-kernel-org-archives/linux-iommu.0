From: Charles Suresh <sureshc-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: High lock contention on async_umap_flush_lock when intel_iommu=on
Date: Thu, 26 Feb 2015 02:06:23 +0000
Message-ID: <0F7CB4A8-139A-4185-B946-D6F2E0CFEA5A@vmware.com>
References: <20150226013842.GA7031@cs-PowerEdge-T320>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
Content-ID: <7C8911A10BE844438F47C031B250B667-xOhs/FgTdIXLi+/K9TH57EEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When bridging traffic across two Intel X540-AT2 NICs using openvswitch(OVS),
I can get ~10 Mpps of small packet (64 byte) traffic on a Dell R620 system
using 2x Intel E5-2650 v2 @ 2.6 GHz using a Spirent generator.

Using the identical system and after enabling intel_iommu=3Don during boot,
the throughput drops to ~500 Kpps.

Looking at the output from perf, I see that ~80% of the CPUs are consumed
spinning on locks. The highest contention appears to be on async_umap_flush=
_lock
acquired in add_unmap. This area of code appears unchanged since it was
introduced back in 2008. The code review back then called out the lack of
scalability of the code as seen in this snippet from =

http://lkml.iu.edu/hypermail/linux/kernel/0802.3/2944.html :

---begin quote---
...
>> +static void add_unmap(struct dmar_domain *dom, struct iova *iova)
>> +{
>> + unsigned long flags;
>> +
>> + spin_lock_irqsave(&async_umap_flush_lock, flags);
> =

> How scalable is this?

Its not very, but I'm doing an insert walk of a list and need the locks.
...
---end quote---

>From looking at bugzilla no one else appears to have reported this issue
so I'm wondering if there is an easy way to side step this - is there a
workaround so that I don't need to use "intel_iommu=3Don"?

I'm testing with the "intel_iommu=3Don" setting so that I can get SR-IOV NI=
Cs
passed through to VMs running over KVM. Is this possible any other way?

Let me know if you want me to open a bug on bugzilla and I can upload the
perf.data and perf report output there instead of attaching large files to =
this
email. For now, if it helps, here's the snippet from the top of perf report:

---begin extract from perf report---
...
    5.43%    ksoftirqd/0  [kernel.kallsyms]   [k] _raw_spin_lock_irqsave   =
                   =

             |
             --- _raw_spin_lock_irqsave
                |          =

                |--62.66%-- add_unmap
                |          |          =

                |          |--99.93%-- intel_unmap_page.part.40
                |          |          intel_unmap_page
                |          |          ixgbe_poll
                |          |          net_rx_action
                |          |          __do_softirq
...
---end extract from perf report---

I=92m not on the iommu alias - so I=92d appreciate being cc=92ed on any rep=
lies.

Thanks,
Charles
