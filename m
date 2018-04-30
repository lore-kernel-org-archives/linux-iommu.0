From: Jintack Lim <jintack-eQaUEPhvms7ENvBUuze7eA@public.gmane.org>
Subject: Re: How to check if Vt-d is capable of posted-interrupt?
Date: Mon, 30 Apr 2018 14:13:49 -0400
Message-ID: <CAHyh4xjaLUibVMRVfCc5_kyqhu=HYDfZXkcLRmWsoZ=KCyo+MQ@mail.gmail.com>
References: <CAHyh4xgMqsxCUOH-_p=DWVWpp0stxfwdfFo2s2cn1nmR2v5Siw@mail.gmail.com>
	<CAHyh4xjzi5CK8+OJPpnr+F2ABpy5Jbbo1S4YR5ATi62LMRn+Pw@mail.gmail.com>
	<20180430120941.741f31cb@w520.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180430120941.741f31cb-DGNDKt5SQtizQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, QEMU Devel Mailing List <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, KVM General <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 30, 2018 at 2:09 PM, Alex Williamson
<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Mon, 30 Apr 2018 13:44:23 -0400
> Jintack Lim <jintack-eQaUEPhvms7ENvBUuze7eA@public.gmane.org> wrote:
>
>> Add iommu mailing list since this question might be more related to iommu.
>>
>> On Mon, Apr 30, 2018 at 10:11 AM, Jintack Lim <jintack-eQaUEPhvms7ENvBUuze7eA@public.gmane.org> wrote:
>> > Hi,
>> >
>> > I wonder how to check if Vt-d is capable of posted-interrupt? I'm
>> > using Intel E5-2630 v3.
>> >
>> > I was once told that APICv and posted-interrupt capability always come
>> > together. But it seems like my cpu support APICv
>> > (/sys/module/kvm_intel/parameters/enable_apicv is Y), but
>> > posted-interrupt capability is only shipped with the next generation
>> > of the cpu (E5-2600 v4, which is Broadwell).
>> >
>> > What would be an easy way to check this?
>
> PI support is bit 59 in the capability register which is exposed
> through sysfs at /sys/class/iommu/dmar*/intel-iommu/cap so you could do
> something like:
>
> # for i in $(find /sys/class/iommu/dmar* -type l); do echo -n "$i: "; echo $(( ( 0x$(cat $i/intel-iommu/cap) >> 59 ) & 1 )); done
>

Thanks for a nice solution, Alex.
It turns out my cpu doesn't have the PI capability.
/sys/class/iommu/dmar0: 0
/sys/class/iommu/dmar1: 0

> I think the relationship between APICv and PI goes the other direction,
> if you have PI, you probably have APICv.  Having APICv implies nothing
> about having PI.  Thanks,

Yeah, I think that makes sense.

Thanks,
Jintack

>
> Alex
>
