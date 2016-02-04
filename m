From: Vijay Kumar <iamcurious456-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Bus error at 0x0 by sysmmu_fimd (Page table base 0x000 0x00
	ad808000)
Date: Thu, 4 Feb 2016 09:32:03 +0530
Message-ID: <CAAVm-g0zjGfhkNyk=+CW=4imWNmvvz6pcqED1ohtsLSOJC9L8g@mail.gmail.com>
References: <CAAVm-g0+YP6pFJbY-28TX9FWuP+My2Vb7aciO_iYx7y_5e4UTw@mail.gmail.com>
	<56AA12E9.5070601@foss.arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1816103607185437730=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <56AA12E9.5070601-VeJGdqYn5oNWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-VeJGdqYn5oNWk0Htik3J/w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============1816103607185437730==
Content-Type: multipart/alternative; boundary=001a114220161dab10052ae9cc0a

--001a114220161dab10052ae9cc0a
Content-Type: text/plain; charset=UTF-8

Hii Robin,
                   I debugged  iommu_map function in iommu.c .In that
function exynos_iommu_map is not called .I noticed that is because of size
variable value 0.I made changes but after in exynos_iommu_map function is
throwing an error "Trying Mapping on 1MB@0xc0000000 that is mapped" .Please
help me to solve this issue.I am unable to find why this error occured .

Thanks and Regards,
Vijay Kumar Prathipati.

On Thu, Jan 28, 2016 at 6:38 PM, Robin Murphy <robin.murphy-VeJGdqYn5oNWk0Htik3J/w@public.gmane.org>
wrote:

> On 28/01/16 04:54, Vijay Kumar wrote:
>
>> Hii all,
>>             I am new to this mailing list and i need some help.I am trying
>> to add exynos iommu support for my board with exynos5250-soc for fimd.I am
>> getting this error at exynos_sysmmu_irq.I am pretty confused with it and
>> didn't know what to do.I strucked at this point.So please explain why this
>> error occurs.My device is attaced correctly to iommu.
>>
>
> It looks like something (either the client device or the sysmmu itself,
> I'm not familiar with that hardware) has tried to access physical address
> 0, and the MMU is raising the interrupt to report that it got an error
> response back for that access. On Exynos 5 that's where the boot ROM stuff
> lives, so there may well be nothing there at all in the non-secure memory
> map. Either way, it's a long way from RAM (which will be somewhere above
> 0x20000000), so you've almost certainly wound up with some bogus mapping in
> your sysmmu page table. First thing I'd try is adding a check in
> exynos_iommu_map() to scream if someone passes in a dodgy-looking physical
> address, then work backwards from there.
>
> Robin.
>
>
>> Thanks and Regards,
>> Vijay Kumar Prathipati.
>>
>>
>>
>> _______________________________________________
>> iommu mailing list
>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
>>
>

--001a114220161dab10052ae9cc0a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hii Robin,<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0I debugged =C2=A0iommu_map function in iommu.c .=
In that function exynos_iommu_map is not called .I noticed that is because =
of size variable value 0.I made changes but after in exynos_iommu_map funct=
ion is throwing an error &quot;Trying Mapping on 1MB@0xc0000000 that is map=
ped&quot; .Please help me to solve this issue.I am unable to find why this =
error occured .</div><div><br></div><div>Thanks and Regards,</div><div>Vija=
y Kumar Prathipati.</div></div><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">On Thu, Jan 28, 2016 at 6:38 PM, Robin Murphy <span dir=3D"lt=
r">&lt;<a href=3D"mailto:robin.murphy-VeJGdqYn5oNWk0Htik3J/w@public.gmane.org" target=3D"_blank">robin=
.murphy-VeJGdqYn5oNWk0Htik3J/w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><span class=3D"">On 28/01/16 04:54, Vijay Kumar wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hii all,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I am new to this mailing list and=
 i need some help.I am trying<br>
to add exynos iommu support for my board with exynos5250-soc for fimd.I am<=
br>
getting this error at exynos_sysmmu_irq.I am pretty confused with it and<br=
>
didn&#39;t know what to do.I strucked at this point.So please explain why t=
his<br>
error occurs.My device is attaced correctly to iommu.<br>
</blockquote>
<br></span>
It looks like something (either the client device or the sysmmu itself, I&#=
39;m not familiar with that hardware) has tried to access physical address =
0, and the MMU is raising the interrupt to report that it got an error resp=
onse back for that access. On Exynos 5 that&#39;s where the boot ROM stuff =
lives, so there may well be nothing there at all in the non-secure memory m=
ap. Either way, it&#39;s a long way from RAM (which will be somewhere above=
 0x20000000), so you&#39;ve almost certainly wound up with some bogus mappi=
ng in your sysmmu page table. First thing I&#39;d try is adding a check in =
exynos_iommu_map() to scream if someone passes in a dodgy-looking physical =
address, then work backwards from there.<br>
<br>
Robin.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><span class=3D"">
<br>
Thanks and Regards,<br>
Vijay Kumar Prathipati.<br>
<br>
<br>
<br></span>
_______________________________________________<br>
iommu mailing list<br>
<a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" target=3D"_blank">iommu=
@lists.linux-foundation.org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu" rel=3D=
"noreferrer" target=3D"_blank">https://lists.linuxfoundation.org/mailman/li=
stinfo/iommu</a><br>
<br>
</blockquote>
<br>
</blockquote></div><br></div>

--001a114220161dab10052ae9cc0a--

--===============1816103607185437730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1816103607185437730==--
