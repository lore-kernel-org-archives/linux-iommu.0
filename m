From: sunnydrake <sunnydrake7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Regression] Amd-Vi + ivrs_ioapic cause kernel oops (4.4, 4.7
	fail 3.9 works)
Date: Tue, 5 Jul 2016 10:46:30 +0300
Message-ID: <577B65D6.6020804@gmail.com>
References: <57786362.1010702@gmail.com>
	<790da4e5-985a-a4f5-1ead-b4fa1f37e8a4@iommu.org>
	<57797A37.4030805@gmail.com>
	<6a84fd9d-6897-2b19-de87-be09722593dc@iommu.org>
	<577B13D5.7030200@gmail.com> <577B26C3.6040108@iommu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6458366715158847270=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <577B26C3.6040108-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a multi-part message in MIME format.
--===============6458366715158847270==
Content-Type: multipart/alternative;
 boundary="------------010300040803040506050703"

This is a multi-part message in MIME format.
--------------010300040803040506050703
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 05.07.16 06:17, Wan Zongshun wrote:
>
>
> On 2016=E5=B9=B407=E6=9C=8805=E6=97=A5 09:56, sunnydrake wrote:
>>
>> On 04.07.16 16:51, Wan Zongshun wrote:
>>>
>>>
>>> =E5=9C=A8 7/4/2016 4:48 AM, sunnydrake =E5=86=99=E9=81=93:
>>>> Thanks for reply.
>>>> On 03.07.16 17:26, Wan Zongshun wrote:
>>>>>
>>>>>
>>>>> =E5=9C=A8 7/3/2016 8:59 AM, sunnydrake =E5=86=99=E9=81=93:
>>>>>> [description]
>>>>>> working in kernel 3.9
>>>>>> Oops in current 4.4.0-28,4.7.0-040700rc5
>>>>>> kernel options ivrs_ioapic[7]=3D00:14.0 ivrs_ioapic[8]=3D00:00.1
>>>>>> workaround to fix ivrs table
>>>>>> cause kernel Oops on boot
>>>>> Do you mean "ivrs_ioapic[7]=3D00:14.0 ivrs_ioapic[8]=3D00:00.1" are
>>>>> workable at kernel-3.9 but failed in kernel-4.4?
>>>> 1)yes kernel 3.9 boots ok with ivrs_ioapic[7]=3D00:14.0
>>>> ivrs_ioapic[8]=3D00:00.1
>>>> kernels 4.4 and 4.7 fall to Oops
>>>>>
>>>>>>
>>>>>> [bug]
>>>>>> oops:
>>>>>> short oops text
>>>>>> AMD-Vi: Completion_wait loop timed Out
>>>>>> BUG: unable to handle kernel NULL pointer dereference at 000..03e
>>>>>> ... irq_pm_install_action+0x1c/0xd0
>>>>>> full oops image text
>>>>>> http://img.ctrlv.in/img/16/07/03/577863055370c.jpg
>>>>>>
>>>>>> [additional info]
>>>>>> dmesg|grep AMD-Vi without ivrs_ioapic[8]=3D00:00.1
>>>>> This log is from the kernel print without ivrs_ioapic[8]=3D00:00.1?
>>>>> Why not provide your kernel log with "ivrs_ioapic[7]=3D00:14.0
>>>>> ivrs_ioapic[8]=3D00:00.1" ?
>>>>> Full kernel log is better.
>>>>>
>>>>
>>>> 2) yes,  because with ivrs_ioapic[7]=3D00:14.0 ivrs_ioapic[8]=3D00:0=
0.1
>>>> kernels are not bootable. Screen of Oops
>>>> http://img.ctrlv.in/img/16/07/03/577863055370c.jpg (this with params
>>>> ivrs_ioapic[7]=3D00:14.0  ivrs_ioapic[8]=3D00:00.1 ). if you need
>>>> something another like kdump, i can provide.
>>>
>>> If you can provide a full kernel log with ivrs_ioapic[7]=3D00:14.0
>>> ivrs_ioapic[8]=3D00:00.1, that is better.
>>> I checked your crash log, and find some things related to i8042 maybe
>>> wrong, it is ps2 relation driver, is it necessary in your system? can
>>> you disable this i8042 firsty to check if your issue is reasoned=20
>>> from it?
>> i have serial port disabled in bios and booting with i8042.no_acpi=3D1
>> does not fix problem. I don't think i8042 related, because
>> i8042_panic_blink  is caps lock blinking when kernel crash (std=20
>> behavior)
>>
>> here is more detailed image of crash
>> http://img.ctrlv.in/img/16/07/05/577b0ec96746e.jpg
>
> This is not enough to check this issue, I just see "AMD-vi CW loop=20
> timoutout...", but I can not see that more info ahead of this timeout.
>
> I guess some pci device dead, and it leads to iommu send command=20
> timeout or else...
>
Unfortunetly kdump cant reproduce this error due to skipping some hw=20
init.. my best bet is somehow reload iommu module while under kdump=20
kernel(Dunno how?). Other findings i have irqbypass    used by=20
kvm,vfio_pci if it related somehow.
My guess(no i do not read iommu code) that after getting ivrs table info=20
it try to remap interrupts and got smashed.

from 4.6 kern
  31  * Called from __setup_irq() with desc->lock held after @action has
  32  * been installed in the action chain.
  33  */
  34 void irq_pm_install_action(struct irq_desc *desc, struct irqaction=20
*action)
  35 {
  36         desc->nr_actions++;
  37
  38         if (action->flags & IRQF_FORCE_RESUME)
  39                 desc->force_resume_depth++;
  40
  41         WARN_ON_ONCE(desc->force_resume_depth &&
  42                      desc->force_resume_depth !=3D desc->nr_actions)=
;
  43
  44         if (action->flags & IRQF_NO_SUSPEND)
  45                 desc->no_suspend_depth++;
  46         else if (action->flags & IRQF_COND_SUSPEND)
  47                 desc->cond_suspend_depth++;
  48
  49         WARN_ON_ONCE(desc->no_suspend_depth &&
  50                      (desc->no_suspend_depth +
  51                         desc->cond_suspend_depth) !=3D desc->nr_acti=
ons);
  52 }
hmm actually checks if irq is shared call in
+/source/kernel/irq/manage.c
1097 /*
1098  * Internal function to register an irqaction - typically used to
1099  * allocate special interrupts that are part of the architecture.
1100  */
1102 __setup_irq(unsigned int irq, struct irq_desc *desc, struct=20
irqaction *new)
1331         irq_pm_install_action(desc, new);
>> Unable to handle null pointer reference at irq_pm_install_action...
>> ok i will setup linux-crashdump and report logs
>>
>


--------------010300040803040506050703
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <br>
    <div class=3D"moz-cite-prefix">On 05.07.16 06:17, Wan Zongshun wrote:=
<br>
    </div>
    <blockquote cite=3D"mid:577B26C3.6040108-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org" type=3D"cite">
      <br>
      <br>
      On 2016=E5=B9=B407=E6=9C=8805=E6=97=A5 09:56, sunnydrake wrote:
      <br>
      <blockquote type=3D"cite">
        <br>
        On 04.07.16 16:51, Wan Zongshun wrote:
        <br>
        <blockquote type=3D"cite">
          <br>
          <br>
          =E5=9C=A8 7/4/2016 4:48 AM, sunnydrake =E5=86=99=E9=81=93:
          <br>
          <blockquote type=3D"cite">Thanks for reply.
            <br>
            On 03.07.16 17:26, Wan Zongshun wrote:
            <br>
            <blockquote type=3D"cite">
              <br>
              <br>
              =E5=9C=A8 7/3/2016 8:59 AM, sunnydrake =E5=86=99=E9=81=93:
              <br>
              <blockquote type=3D"cite">[description]
                <br>
                working in kernel 3.9
                <br>
                Oops in current 4.4.0-28,4.7.0-040700rc5
                <br>
                kernel options ivrs_ioapic[7]=3D00:14.0
                ivrs_ioapic[8]=3D00:00.1
                <br>
                workaround to fix ivrs table
                <br>
                cause kernel Oops on boot
                <br>
              </blockquote>
              Do you mean "ivrs_ioapic[7]=3D00:14.0=C2=A0
              ivrs_ioapic[8]=3D00:00.1" are
              <br>
              workable at kernel-3.9 but failed in kernel-4.4?
              <br>
            </blockquote>
            1)yes kernel 3.9 boots ok with ivrs_ioapic[7]=3D00:14.0
            <br>
            ivrs_ioapic[8]=3D00:00.1
            <br>
            kernels 4.4 and 4.7 fall to Oops
            <br>
            <blockquote type=3D"cite">
              <br>
              <blockquote type=3D"cite">
                <br>
                [bug]
                <br>
                oops:
                <br>
                short oops text
                <br>
                AMD-Vi: Completion_wait loop timed Out
                <br>
                BUG: unable to handle kernel NULL pointer dereference at
                000..03e
                <br>
                ... irq_pm_install_action+0x1c/0xd0
                <br>
                full oops image text
                <br>
                <a class=3D"moz-txt-link-freetext" href=3D"http://img.ctr=
lv.in/img/16/07/03/577863055370c.jpg">http://img.ctrlv.in/img/16/07/03/57=
7863055370c.jpg</a>
                <br>
                <br>
                [additional info]
                <br>
                dmesg|grep AMD-Vi without ivrs_ioapic[8]=3D00:00.1
                <br>
              </blockquote>
              This log is from the kernel print without
              ivrs_ioapic[8]=3D00:00.1?
              <br>
              Why not provide your kernel log with
              "ivrs_ioapic[7]=3D00:14.0
              <br>
              ivrs_ioapic[8]=3D00:00.1" ?
              <br>
              Full kernel log is better.
              <br>
              <br>
            </blockquote>
            <br>
            2) yes,=C2=A0 because with ivrs_ioapic[7]=3D00:14.0
            ivrs_ioapic[8]=3D00:00.1
            <br>
            kernels are not bootable. Screen of Oops
            <br>
            <a class=3D"moz-txt-link-freetext" href=3D"http://img.ctrlv.i=
n/img/16/07/03/577863055370c.jpg">http://img.ctrlv.in/img/16/07/03/577863=
055370c.jpg</a> (this
            with params
            <br>
            ivrs_ioapic[7]=3D00:14.0=C2=A0 ivrs_ioapic[8]=3D00:00.1 ). if=
 you
            need
            <br>
            something another like kdump, i can provide.
            <br>
          </blockquote>
          <br>
          If you can provide a full kernel log with
          ivrs_ioapic[7]=3D00:14.0
          <br>
          ivrs_ioapic[8]=3D00:00.1, that is better.
          <br>
          I checked your crash log, and find some things related to
          i8042 maybe
          <br>
          wrong, it is ps2 relation driver, is it necessary in your
          system? can
          <br>
          you disable this i8042 firsty to check if your issue is
          reasoned from it?
          <br>
        </blockquote>
        i have serial port disabled in bios and booting with
        i8042.no_acpi=3D1
        <br>
        does not fix problem. I don't think i8042 related, because
        <br>
        i8042_panic_blink=C2=A0 is caps lock blinking when kernel crash (=
std
        behavior)
        <br>
        <br>
        here is more detailed image of crash
        <br>
        <a class=3D"moz-txt-link-freetext" href=3D"http://img.ctrlv.in/im=
g/16/07/05/577b0ec96746e.jpg">http://img.ctrlv.in/img/16/07/05/577b0ec967=
46e.jpg</a>
        <br>
      </blockquote>
      <br>
      This is not enough to check this issue, I just see "AMD-vi CW loop
      timoutout...", but I can not see that more info ahead of this
      timeout.
      <br>
      <br>
      I guess some pci device dead, and it leads to iommu send command
      timeout or else...
      <br>
      <br>
    </blockquote>
    Unfortunetly kdump cant reproduce this error due to skipping some hw
    init.. my best bet is somehow reload iommu module while under kdump
    kernel(Dunno how?). Other findings i have irqbypass=C2=A0=C2=A0=C2=A0=
 used by
    kvm,vfio_pci if it related somehow.<br>
    My guess(no i do not read iommu code) that after getting ivrs table
    info it try to remap interrupts and got smashed.<br>
    <br>
    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf=
-8">
    from 4.6 kern<br>
    =C2=A031=C2=A0 * Called from __setup_irq() with desc-&gt;lock held af=
ter
    @action has<br>
    =C2=A032=C2=A0 * been installed in the action chain.<br>
    =C2=A033=C2=A0 */<br>
    =C2=A034 void irq_pm_install_action(struct irq_desc *desc, struct
    irqaction *action)<br>
    =C2=A035 {<br>
    =C2=A036=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 desc-&gt;nr_=
actions++;<br>
    =C2=A037 <br>
    =C2=A038=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (action-&=
gt;flags &amp; IRQF_FORCE_RESUME)<br>
    =C2=A039=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 desc-&gt;force_resume_depth++;<br>
    =C2=A040 <br>
    =C2=A041=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE=
(desc-&gt;force_resume_depth &amp;&amp;<br>
    =C2=A042=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 desc-&gt;=
force_resume_depth !=3D
    desc-&gt;nr_actions);<br>
    =C2=A043 <br>
    =C2=A044=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (action-&=
gt;flags &amp; IRQF_NO_SUSPEND)<br>
    =C2=A045=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 desc-&gt;no_suspend_depth++;<br>
    =C2=A046=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (act=
ion-&gt;flags &amp; IRQF_COND_SUSPEND)<br>
    =C2=A047=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 desc-&gt;cond_suspend_depth++;<br>
    =C2=A048 <br>
    =C2=A049=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE=
(desc-&gt;no_suspend_depth &amp;&amp;<br>
    =C2=A050=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (desc-&gt=
;no_suspend_depth +<br>
    =C2=A051=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 desc-&gt;cond_suspend_depth) !=3D
    desc-&gt;nr_actions);<br>
    =C2=A052 }<br>
    hmm actually checks if irq is shared call in<br>
    +/source/kernel/irq/manage.c<br>
    1097 /*<br>
    1098=C2=A0 * Internal function to register an irqaction - typically u=
sed
    to<br>
    1099=C2=A0 * allocate special interrupts that are part of the
    architecture.<br>
    1100=C2=A0 */<br>
    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf=
-8">
    1102 __setup_irq(unsigned int irq, struct irq_desc *desc, struct
    irqaction *new)<br>
    1331=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_pm_install_a=
ction(desc, new);<br>
    <blockquote cite=3D"mid:577B26C3.6040108-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org" type=3D"cite">
      <blockquote type=3D"cite">Unable to handle null pointer reference a=
t
        irq_pm_install_action...
        <br>
        ok i will setup linux-crashdump and report logs
        <br>
        <br>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------010300040803040506050703--

--===============6458366715158847270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6458366715158847270==--
