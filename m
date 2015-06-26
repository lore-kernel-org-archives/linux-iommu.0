From: fandongdong <fandd-6gUaA8visnnQT0dZR+AlfA@public.gmane.org>
Subject: Re: Panic when cpu hot-remove
Date: Fri, 26 Jun 2015 17:35:39 +0800
Message-ID: <558D1CEB.3050804@inspur.com>
References: <42BB8332972FC149B81C55A0D41E3A79C07469@jtjnmailbox06.home.langchao.com>
	<20150617115238.GC27750@8bytes.org>
	<1434551800.5628.5.camel@redhat.com>
	<558259BD.7080402@linux.intel.com> <558272E3.4000504@inspur.com>
	<55827927.4080504@inspur.com> <558BB7B8.7000402@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3638302962373984926=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <558BB7B8.7000402-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedeljoro <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Roland Dreier <roland-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?B?6Zer5pmT5bOw?= <yanxiaofeng-6gUaA8visnnQT0dZR+AlfA@public.gmane.org>, "jiang.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <jiang.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?B?5YiY6ZW/55Sf?= <liuchangsheng-6gUaA8visnnQT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============3638302962373984926==
Content-Type: multipart/alternative;
	boundary="------------040004090809010205080604"

--------------040004090809010205080604
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2015/6/25 16:11, Jiang Liu =E5=86=99=E9=81=93:
> On 2015/6/18 15:54, fandongdong wrote:
>>
>> =E5=9C=A8 2015/6/18 15:27, fandongdong =E5=86=99=E9=81=93:
>>>
>>> =E5=9C=A8 2015/6/18 13:40, Jiang Liu =E5=86=99=E9=81=93:
>>>> On 2015/6/17 22:36, Alex Williamson wrote:
>>>>> On Wed, 2015-06-17 at 13:52 +0200, Joerg Roedeljoro wrote:
>>>>>> On Wed, Jun 17, 2015 at 10:42:49AM +0000, =E8=8C=83=E5=86=AC=E5=86=
=AC wrote:
>>>>>>> Hi maintainer,
>>>>>>>
>>>>>>> We found a problem that a panic happen when cpu was hot-removed.
>>>>>>> We also trace the problem according to the calltrace information.
>>>>>>> An endless loop happen because value head is not equal to value
>>>>>>> tail forever in the function qi_check_fault( ).
>>>>>>> The location code is as follows:
>>>>>>>
>>>>>>>
>>>>>>> do {
>>>>>>>           if (qi->desc_status[head] =3D=3D QI_IN_USE)
>>>>>>>           qi->desc_status[head] =3D QI_ABORT;
>>>>>>>           head =3D (head - 2 + QI_LENGTH) % QI_LENGTH;
>>>>>>>       } while (head !=3D tail);
>>>>>> Hmm, this code interates only over every second QI descriptor, and
>>>>>> tail
>>>>>> probably points to a descriptor that is not iterated over.
>>>>>>
>>>>>> Jiang, can you please have a look?
>>>>> I think that part is normal, the way we use the queue is to always
>>>>> submit a work operation followed by a wait operation so that we can
>>>>> determine the work operation is complete.  That's done via
>>>>> qi_submit_sync().  We have had spurious reports of the queue gettin=
g
>>>>> impossibly out of sync though.  I saw one that was somehow linked t=
o
>>>>> the
>>>>> I/O AT DMA engine.  Roland Dreier saw something similar[1]. I'm not
>>>>> sure if they're related to this, but maybe worth comparing. Thanks,
>>>> Thanks, Alex and Joerg!
>>>>
>>>> Hi Dongdong,
>>>>      Could you please help to give some instructions about how to
>>>> reproduce this issue? I will try to reproduce it if possible.
>>>> Thanks!
>>>> Gerry
>>> Hi Gerry,
>>>
>>> We're running kernel 4.1.0 on a 4-socket system and  we want to
>>> offline socket 1.
>>> Steps as follows:
>>>
>>> echo 1 > /sys/firmware/acpi/hotplug/force_remove
>>> echo 1 > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0004:01/eject
> Hi Dongdong,
> 	I failed to reproduce this issue on my side. Some please help
> to confirm?
> 1) Is this issue reproducible on your side?
> 2) Does this issue happen if you disable irqbalance service on you
>     system?
> 3) Has the corresponding PCI host bridge been removed before removing
>     the socket?
>
> >From the log message, we only noticed log messages for CPU and memory,
> but not messages for PCI (IOMMU) devices. And this log message
> 	"[ 149.976493] acpi ACPI0004:01: Still not present"
> implies that the socket has been powered off during the ejection.
> So the story may be that you powered off the socket while the host
> bridge on the socket is still in use.
> Thanks!
> Gerry
Hi Gerry,
             Thanks for your suggestion!
             The issue didn't happen after removing the corresponding=20
PCI host bridge.
  Thanks!
  Dongdong
>
> .
>


--------------040004090809010205080604
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <br>
    <br>
    <div class=3D"moz-cite-prefix">=E5=9C=A8 2015/6/25 16:11, Jiang Liu =E5=
=86=99=E9=81=93:<br>
    </div>
    <blockquote cite=3D"mid:558BB7B8.7000402-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" type=3D"cit=
e">
      <pre wrap=3D"">On 2015/6/18 15:54, fandongdong wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">

=E5=9C=A8 2015/6/18 15:27, fandongdong =E5=86=99=E9=81=93:
</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"">

=E5=9C=A8 2015/6/18 13:40, Jiang Liu =E5=86=99=E9=81=93:
</pre>
          <blockquote type=3D"cite">
            <pre wrap=3D"">On 2015/6/17 22:36, Alex Williamson wrote:
</pre>
            <blockquote type=3D"cite">
              <pre wrap=3D"">On Wed, 2015-06-17 at 13:52 +0200, Joerg Roe=
deljoro wrote:
</pre>
              <blockquote type=3D"cite">
                <pre wrap=3D"">On Wed, Jun 17, 2015 at 10:42:49AM +0000, =
=E8=8C=83=E5=86=AC=E5=86=AC wrote:
</pre>
                <blockquote type=3D"cite">
                  <pre wrap=3D"">Hi maintainer,

We found a problem that a panic happen when cpu was hot-removed.
We also trace the problem according to the calltrace information.
An endless loop happen because value head is not equal to value
tail forever in the function qi_check_fault( ).
The location code is as follows:


do {
         if (qi-&gt;desc_status[head] =3D=3D QI_IN_USE)
         qi-&gt;desc_status[head] =3D QI_ABORT;
         head =3D (head - 2 + QI_LENGTH) % QI_LENGTH;
     } while (head !=3D tail);
</pre>
                </blockquote>
                <pre wrap=3D"">Hmm, this code interates only over every s=
econd QI descriptor, and
tail
probably points to a descriptor that is not iterated over.

Jiang, can you please have a look?
</pre>
              </blockquote>
              <pre wrap=3D"">I think that part is normal, the way we use =
the queue is to always
submit a work operation followed by a wait operation so that we can
determine the work operation is complete.  That's done via
qi_submit_sync().  We have had spurious reports of the queue getting
impossibly out of sync though.  I saw one that was somehow linked to
the
I/O AT DMA engine.  Roland Dreier saw something similar[1]. I'm not
sure if they're related to this, but maybe worth comparing. Thanks,
</pre>
            </blockquote>
            <pre wrap=3D"">Thanks, Alex and Joerg!

Hi Dongdong,
    Could you please help to give some instructions about how to
reproduce this issue? I will try to reproduce it if possible.
Thanks!
Gerry
</pre>
          </blockquote>
          <pre wrap=3D"">Hi Gerry,

We're running kernel 4.1.0 on a 4-socket system and  we want to
offline socket 1.
Steps as follows:

echo 1 &gt; /sys/firmware/acpi/hotplug/force_remove
echo 1 &gt; /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0004:01/eject
</pre>
        </blockquote>
      </blockquote>
      <pre wrap=3D"">Hi Dongdong,
	I failed to reproduce this issue on my side. Some please help
to confirm?
1) Is this issue reproducible on your side?
2) Does this issue happen if you disable irqbalance service on you
   system?
3) Has the corresponding PCI host bridge been removed before removing
   the socket?

&gt;From the log message, we only noticed log messages for CPU and memory=
,
but not messages for PCI (IOMMU) devices. And this log message
	"[ 149.976493] acpi ACPI0004:01: Still not present"
implies that the socket has been powered off during the ejection.
So the story may be that you powered off the socket while the host
bridge on the socket is still in use.
Thanks!
Gerry</pre>
    </blockquote>
    Hi Gerry,<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Th=
anks for your suggestion!<span style=3D"color: rgb(0, 0,
      0); font-family: Ubuntubeta, Ubuntu, 'Bitstream Vera Sans',
      'DejaVu Sans', Tahoma, sans-serif; font-size: 13px; font-style:
      normal; font-variant: normal; font-weight: normal; letter-spacing:
      normal; line-height: 15px; orphans: auto; text-align: left;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(235, 236, 228); display: inline !important;
      float: none;"><span class=3D"Apple-converted-space"></span></span><=
br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Th=
e issue didn't happen after removing the corresponding
    PCI host bridge. <br>
    =C2=A0Thanks!<br>
    =C2=A0Dongdong<br>
    <blockquote cite=3D"mid:558BB7B8.7000402-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" type=3D"cit=
e">
      <pre wrap=3D"">

.

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------040004090809010205080604--

--===============3638302962373984926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3638302962373984926==--
