From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/4] iommu/exynos: enhancements of System MMU driver with
	DT
Date: Mon, 19 Nov 2012 17:12:03 +0900
Message-ID: <CAHQjnONgB_OM-hVtf8UYLr=HexxQtAiDtf_VKZfr02mUCi4=Vw@mail.gmail.com>
References: <002401cdc245$32dbf3e0$9893dba0$%cho@samsung.com>
	<20121117124918.GC11220@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6294557313197911486=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20121117124918.GC11220-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Subash Patel <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sanghyun Lee <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============6294557313197911486==
Content-Type: multipart/alternative; boundary=f46d042d058c2ddc2304ced4acd8

--f46d042d058c2ddc2304ced4acd8
Content-Type: text/plain; charset=ISO-8859-1

On Saturday, November 17, 2012, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Nov 14, 2012 at 05:51:12PM +0900, Cho KyongHo wrote:
>> This commit enhances power management of System MMU and its client
>> devices with the following changes:
>>  - Each System MMU device becomes the parent device of its client
>>    device while probe(). Thus, exynos-iommu driver must be initialized
>>    before client devices.
>>  - System MMU driver does not pm_runtime_get/put() by itself and runtime
>>    power gating is performed by client devices.
>>  - System is safe when suspend/resume without any care by client device
>>    drivers.
>>
>> In addition, System MMUs can be seperate into several groups that are
>> belongs to a single client device like FIMC-IS block. If such blocks are
>> controlled by a single device descriptor, all System MMUs in the blocks
>> must be enabled/disabled by a single device descriptor. The problem is
>> that clock gating and power gating may be not the same among all System
>> MMUs in the blocks. Thus, System MMUs are grouped by clock gating and
>> power gating and they are chained by parent-child relationships.
>>
>> exynos-iommu driver now also supports debugfs to identify the state of
>> each System MMU.
>>
>> The last big change is to support DT. The desription of the properties
>> of DT nodes are described in the source file.
>>
>> Signed-off-by: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  drivers/iommu/Kconfig        |   17 +-
>>  drivers/iommu/exynos-iommu.c | 1420
+++++++++++++++++++++++++++++++-----------
>>  2 files changed, 1077 insertions(+), 360 deletions(-)
>
> This patch does multiple things and is quite large. Please split it down
> into reasonable chunks and resubmit.
>
> Patches 1-3 look good to me and I do not mind taking them for 3.8.
> Please let me know if you prefer these patches standalone in 3.8 or
> together with this patch split up.
>

Thank you for review.
I am splitting the fourth patch and will post it by tomorrow.

The current driver does not be probed with the first 3 patches.
I want them to be in 3,8 together.

Cho KyongHo

--f46d042d058c2ddc2304ced4acd8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, November 17, 2012, Joerg Roedel &lt;<a href=3D"mailto:=
joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org">joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org</a>&gt; wrote:<br>&gt; On Wed, Nov 14, 201=
2 at 05:51:12PM +0900, Cho KyongHo wrote:<br>&gt;&gt; This commit enhances =
power management of System MMU and its client<br>
&gt;&gt; devices with the following changes:<br>&gt;&gt; =A0- Each System M=
MU device becomes the parent device of its client<br>&gt;&gt; =A0 =A0device=
 while probe(). Thus, exynos-iommu driver must be initialized<br>&gt;&gt; =
=A0 =A0before client devices.<br>
&gt;&gt; =A0- System MMU driver does not pm_runtime_get/put() by itself and=
 runtime<br>&gt;&gt; =A0 =A0power gating is performed by client devices.<br=
>&gt;&gt; =A0- System is safe when suspend/resume without any care by clien=
t device<br>
&gt;&gt; =A0 =A0drivers.<br>&gt;&gt;<br>&gt;&gt; In addition, System MMUs c=
an be seperate into several groups that are<br>&gt;&gt; belongs to a single=
 client device like FIMC-IS block. If such blocks are<br>&gt;&gt; controlle=
d by a single device descriptor, all System MMUs in the blocks<br>
&gt;&gt; must be enabled/disabled by a single device descriptor. The proble=
m is<br>&gt;&gt; that clock gating and power gating may be not the same amo=
ng all System<br>&gt;&gt; MMUs in the blocks. Thus, System MMUs are grouped=
 by clock gating and<br>
&gt;&gt; power gating and they are chained by parent-child relationships.<b=
r>&gt;&gt;<br>&gt;&gt; exynos-iommu driver now also supports debugfs to ide=
ntify the state of<br>&gt;&gt; each System MMU.<br>&gt;&gt;<br>&gt;&gt; The=
 last big change is to support DT. The desription of the properties<br>
&gt;&gt; of DT nodes are described in the source file.<br>&gt;&gt;<br>&gt;&=
gt; Signed-off-by: KyongHo Cho &lt;<a href=3D"mailto:pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org=
">pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>&gt;&gt; ---<br>&gt;&gt; =A0drivers/iom=
mu/Kconfig =A0 =A0 =A0 =A0| =A0 17 +-<br>
&gt;&gt; =A0drivers/iommu/exynos-iommu.c | 1420 +++++++++++++++++++++++++++=
++++-----------<br>&gt;&gt; =A02 files changed, 1077 insertions(+), 360 del=
etions(-)<br>&gt;<br>&gt; This patch does multiple things and is quite larg=
e. Please split it down<br>
&gt; into reasonable chunks and resubmit.<br>&gt;<br>&gt; Patches 1-3 look =
good to me and I do not mind taking them for 3.8.<br>&gt; Please let me kno=
w if you prefer these patches standalone in 3.8 or<br>&gt; together with th=
is patch split up.<br>
&gt;<br><br>Thank you for review.<br>I am splitting the fourth patch and wi=
ll post it by tomorrow.<br><br>The current driver does not be probed with t=
he first 3 patches.<br>I want them to be in 3,8 together.<br><br>Cho KyongH=
o

--f46d042d058c2ddc2304ced4acd8--

--===============6294557313197911486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6294557313197911486==--
