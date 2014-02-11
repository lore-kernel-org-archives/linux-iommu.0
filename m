From: Kukjin Kim <kgene.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/exynos: Remove driver
Date: Tue, 11 Feb 2014 11:51:09 +0530
Message-ID: <CAL5jtJmfwajFD0cnYt6gOfFsZ5hGbFi=5kv8g4x23fY6qGBOew@mail.gmail.com>
References: <1391716317-20300-1-git-send-email-olof@lixom.net>
	<CAAQKjZMo6=dtur6NfvDY9=jVF=7VxHub=isnEwPw0+RKCq6xAg@mail.gmail.com>
	<CAH9JG2Xoz1_Y7CV6FUiGAO9o5T7jtFUYqJpcAysLttwu4527zQ@mail.gmail.com>
	<52F4E481.3050902@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7210698855061498746=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <52F4E481.3050902-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============7210698855061498746==
Content-Type: multipart/alternative; boundary=047d7bdc7d525007e404f21b764f

--047d7bdc7d525007e404f21b764f
Content-Type: text/plain; charset=ISO-8859-1

2014-02-07 19:19 GMT+05:30 Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
> Hello,
>
> On 2014-02-07 13:44, Kyungmin Park wrote:
>>
>>
>> On Friday, February 7, 2014, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
>> <mailto:inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>> wrote:
>>
>>     2014-02-07 Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org <javascript:;>>:
>>
>>     > The driver has been unbuildable due to unfulfilled dependencies
>>     since
>>     > 3.11, and even if enabled it won't build due to build breakage.
>>     Emails
>>     > about status on this have gone unanswered, and fixes seem to
>>     have been
>>     > abandoned.
>>     >
>>     > It's obvious that nobody cares about it, so let's remove it.
>>
>>     Wait, we are going to fix up this module. It seems that KyoungHo,
>>     original author, is busy with some works related to product.
>>
>>     we can care about it if KyoungHo cannot afford to care for the
>>     time being.
>>
>> Any volunteers?
>> Marek or Bartek, how do you think?
>>
>> Before that it makes orphan or unsupported at maintainer file first and
>> change it to new volunteers.
>
>
> I think that it might be easier to remove the existing non-functional
driver
> now and add it again once the driver is ready. I have it on my TODO list,
> but
> doubt I will manage to finish it for v3.15.
>
> Discussing the DT bindings might take some time.
>
Just adding KyongHo Cho.

If he can fixup for this time, it would be best solution because he knows
well than others, I think.

Thanks,
Kukjin

--047d7bdc7d525007e404f21b764f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">2014-02-07 19:19 GMT+05:30 Marek Szyprowski &lt;<a href=3D=
"mailto:m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;:<br>&gt;=
 Hello,<br>&gt;<br>&gt; On 2014-02-07 13:44, Kyungmin Park wrote:<br>&gt;&g=
t;<br>
&gt;&gt;<br>&gt;&gt; On Friday, February 7, 2014, Inki Dae &lt;<a href=3D"m=
ailto:inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a><br>&gt;&gt; &lt;mailto=
:<a href=3D"mailto:inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;&gt; w=
rote:<br>
&gt;&gt;<br>&gt;&gt; =A0 =A0 2014-02-07 Olof Johansson &lt;<a href=3D"mailt=
o:olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org">olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org</a> &lt;javascript:;&gt;&gt;:<br>&gt;&gt;<=
br>&gt;&gt; =A0 =A0 &gt; The driver has been unbuildable due to unfulfilled=
 dependencies<br>
&gt;&gt; =A0 =A0 since<br>&gt;&gt; =A0 =A0 &gt; 3.11, and even if enabled i=
t won&#39;t build due to build breakage.<br>&gt;&gt; =A0 =A0 Emails<br>&gt;=
&gt; =A0 =A0 &gt; about status on this have gone unanswered, and fixes seem=
 to<br>&gt;&gt; =A0 =A0 have been<br>
&gt;&gt; =A0 =A0 &gt; abandoned.<br>&gt;&gt; =A0 =A0 &gt;<br>&gt;&gt; =A0 =
=A0 &gt; It&#39;s obvious that nobody cares about it, so let&#39;s remove i=
t.<br>&gt;&gt;<br>&gt;&gt; =A0 =A0 Wait, we are going to fix up this module=
. It seems that KyoungHo,<br>
&gt;&gt; =A0 =A0 original author, is busy with some works related to produc=
t.<br>&gt;&gt;<br>&gt;&gt; =A0 =A0 we can care about it if KyoungHo cannot =
afford to care for the<br>&gt;&gt; =A0 =A0 time being.<br>&gt;&gt;<br>&gt;&=
gt; Any volunteers?<br>
&gt;&gt; Marek or Bartek, how do you think?<br>&gt;&gt;<br>&gt;&gt; Before =
that it makes orphan or unsupported at maintainer file first and<br>&gt;&gt=
; change it to new volunteers.<br>&gt;<br>&gt;<br>&gt; I think that it migh=
t be easier to remove the existing non-functional driver<br>
&gt; now and add it again once the driver is ready. I have it on my TODO li=
st,<br>&gt; but<br>&gt; doubt I will manage to finish it for v3.15.<br>&gt;=
<br>&gt; Discussing the DT bindings might take some time.<br>&gt;<br>Just a=
dding KyongHo Cho.<br>
<br>If he can fixup for this time, it would be best solution because he kno=
ws well than others, I think.<br><br>Thanks,<br>Kukjin<br><br></div>

--047d7bdc7d525007e404f21b764f--

--===============7210698855061498746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7210698855061498746==--
