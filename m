From: sunnydrake <sunnydrake7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Regression] Amd-Vi + ivrs_ioapic cause kernel oops (4.4, 4.7
	fail 3.9 works)
Date: Tue, 5 Jul 2016 04:56:37 +0300
Message-ID: <577B13D5.7030200@gmail.com>
References: <57786362.1010702@gmail.com>
	<790da4e5-985a-a4f5-1ead-b4fa1f37e8a4@iommu.org>
	<57797A37.4030805@gmail.com>
	<6a84fd9d-6897-2b19-de87-be09722593dc@iommu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4045446699987824600=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6a84fd9d-6897-2b19-de87-be09722593dc-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
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
--===============4045446699987824600==
Content-Type: multipart/alternative;
 boundary="------------060304000901010905020408"

This is a multi-part message in MIME format.
--------------060304000901010905020408
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 04.07.16 16:51, Wan Zongshun wrote:
>
>
> =E5=9C=A8 7/4/2016 4:48 AM, sunnydrake =E5=86=99=E9=81=93:
>> Thanks for reply.
>> On 03.07.16 17:26, Wan Zongshun wrote:
>>>
>>>
>>> =E5=9C=A8 7/3/2016 8:59 AM, sunnydrake =E5=86=99=E9=81=93:
>>>> [description]
>>>> working in kernel 3.9
>>>> Oops in current 4.4.0-28,4.7.0-040700rc5
>>>> kernel options ivrs_ioapic[7]=3D00:14.0 ivrs_ioapic[8]=3D00:00.1=20
>>>> workaround to fix ivrs table
>>>> cause kernel Oops on boot
>>> Do you mean "ivrs_ioapic[7]=3D00:14.0  ivrs_ioapic[8]=3D00:00.1" are=20
>>> workable at kernel-3.9 but failed in kernel-4.4?
>> 1)yes kernel 3.9 boots ok with ivrs_ioapic[7]=3D00:14.0=20
>> ivrs_ioapic[8]=3D00:00.1
>> kernels 4.4 and 4.7 fall to Oops
>>>
>>>>
>>>> [bug]
>>>> oops:
>>>> short oops text
>>>> AMD-Vi: Completion_wait loop timed Out
>>>> BUG: unable to handle kernel NULL pointer dereference at 000..03e
>>>> ... irq_pm_install_action+0x1c/0xd0
>>>> full oops image text
>>>> http://img.ctrlv.in/img/16/07/03/577863055370c.jpg
>>>>
>>>> [additional info]
>>>> dmesg|grep AMD-Vi without ivrs_ioapic[8]=3D00:00.1
>>> This log is from the kernel print without ivrs_ioapic[8]=3D00:00.1?
>>> Why not provide your kernel log with "ivrs_ioapic[7]=3D00:14.0=20
>>> ivrs_ioapic[8]=3D00:00.1" ?
>>> Full kernel log is better.
>>>
>>
>> 2) yes,  because with ivrs_ioapic[7]=3D00:14.0 ivrs_ioapic[8]=3D00:00.=
1=20
>> kernels are not bootable. Screen of Oops=20
>> http://img.ctrlv.in/img/16/07/03/577863055370c.jpg (this with params=20
>> ivrs_ioapic[7]=3D00:14.0  ivrs_ioapic[8]=3D00:00.1 ). if you need=20
>> something another like kdump, i can provide.
>
> If you can provide a full kernel log with ivrs_ioapic[7]=3D00:14.0=20
> ivrs_ioapic[8]=3D00:00.1, that is better.
> I checked your crash log, and find some things related to i8042 maybe=20
> wrong, it is ps2 relation driver, is it necessary in your system? can=20
> you disable this i8042 firsty to check if your issue is reasoned from i=
t?
i have serial port disabled in bios and booting with i8042.no_acpi=3D1=20
does not fix problem. I don't think i8042 related, because=20
i8042_panic_blink  is caps lock blinking when kernel crash (std behavior)

here is more detailed image of crash=20
http://img.ctrlv.in/img/16/07/05/577b0ec96746e.jpg
Unable to handle null pointer reference at irq_pm_install_action...
ok i will setup linux-crashdump and report logs

--------------060304000901010905020408
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <br>
    <div class=3D"moz-cite-prefix">On 04.07.16 16:51, Wan Zongshun wrote:=
<br>
    </div>
    <blockquote
      cite=3D"mid:6a84fd9d-6897-2b19-de87-be09722593dc-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org"
      type=3D"cite">
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
            kernel options ivrs_ioapic[7]=3D00:14.0 ivrs_ioapic[8]=3D00:0=
0.1
            workaround to fix ivrs table
            <br>
            cause kernel Oops on boot
            <br>
          </blockquote>
          Do you mean "ivrs_ioapic[7]=3D00:14.0=C2=A0 ivrs_ioapic[8]=3D00=
:00.1"
          are workable at kernel-3.9 but failed in kernel-4.4?
          <br>
        </blockquote>
        1)yes kernel 3.9 boots ok with ivrs_ioapic[7]=3D00:14.0
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
            <a class=3D"moz-txt-link-freetext" href=3D"http://img.ctrlv.i=
n/img/16/07/03/577863055370c.jpg">http://img.ctrlv.in/img/16/07/03/577863=
055370c.jpg</a>
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
          Why not provide your kernel log with "ivrs_ioapic[7]=3D00:14.0
          ivrs_ioapic[8]=3D00:00.1" ?
          <br>
          Full kernel log is better.
          <br>
          <br>
        </blockquote>
        <br>
        2) yes,=C2=A0 because with ivrs_ioapic[7]=3D00:14.0
        ivrs_ioapic[8]=3D00:00.1 kernels are not bootable. Screen of Oops
        <a class=3D"moz-txt-link-freetext" href=3D"http://img.ctrlv.in/im=
g/16/07/03/577863055370c.jpg">http://img.ctrlv.in/img/16/07/03/5778630553=
70c.jpg</a> (this with
        params ivrs_ioapic[7]=3D00:14.0=C2=A0 ivrs_ioapic[8]=3D00:00.1 ).=
 if you
        need something another like kdump, i can provide.
        <br>
      </blockquote>
      <br>
      If you can provide a full kernel log with ivrs_ioapic[7]=3D00:14.0
      ivrs_ioapic[8]=3D00:00.1, that is better.
      <br>
      I checked your crash log, and find some things related to i8042
      maybe wrong, it is ps2 relation driver, is it necessary in your
      system? can you disable this i8042 firsty to check if your issue
      is reasoned from it?
      <br>
    </blockquote>
    i have serial port disabled in bios and booting with i8042.no_acpi=3D=
1
    does not fix problem. I don't think i8042 related, because
    i8042_panic_blink=C2=A0 is caps lock blinking when kernel crash (std
    behavior)<br>
    <br>
    here is more detailed image of crash
    <a class=3D"moz-txt-link-freetext" href=3D"http://img.ctrlv.in/img/16=
/07/05/577b0ec96746e.jpg">http://img.ctrlv.in/img/16/07/05/577b0ec96746e.=
jpg</a><br>
    Unable to handle null pointer reference at irq_pm_install_action...<b=
r>
    ok i will setup linux-crashdump and report logs
    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf=
-8">
  </body>
</html>

--------------060304000901010905020408--

--===============4045446699987824600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4045446699987824600==--
