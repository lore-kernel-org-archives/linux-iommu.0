From: Tom Murphy <murphyt7-/Zw1syy4LHg@public.gmane.org>
Subject: Re: [PATCH] Changing the AMD IOMMU API path to work in an atomic
	context which is necessary for any custom drivers using the IOMMU API
	while holding a spinlock.
Date: Fri, 24 Aug 2018 23:51:32 +0100
Message-ID: <CALQxJuuWqiygrGMVjZ0j-AxBZOskoNHfdYoHEwW4Zgigqjf7kg@mail.gmail.com>
References: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
	<20180824145328.GA7996@infradead.org>
	<24d3f04a-e6e2-ed8f-e2bd-b38144f33f26@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0718160895548011127=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <24d3f04a-e6e2-ed8f-e2bd-b38144f33f26-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============0718160895548011127==
Content-Type: multipart/alternative; boundary="0000000000009aa7c305743637e6"

--0000000000009aa7c305743637e6
Content-Type: text/plain; charset="UTF-8"

The reason we want this change is so we can use iommu_group's to force our
pcie devices to have the same IOMMU mappings. For legacy reasons we require
a bunch of our pcie devices to have the same address translation.

We were going to do this by using the iommu-dma api and replacing all the
existing calls to .

On 24 August 2018 at 16:24, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:

> On 24/08/18 15:53, Christoph Hellwig wrote:
>
>> On Fri, Aug 24, 2018 at 02:28:49PM +0000, murphyt7-/Zw1syy4LHg@public.gmane.org wrote:
>>
>>> From: Tom Murphy <murphyt7-/Zw1syy4LHg@public.gmane.org>
>>>
>>> ---
>>>
>>> This patch allows the IOMMU API path in the AMD driver to be called from
>>> an atomic context.
>>> This is useful for anyone building a driver which needs to call the
>>> IOMMU API while holding a spinlock.
>>>
>>
>> I don't think that is a good idea.  Please point to the code in the
>> driver and we can't probably find a better solution.
>>
>
> Although IIRC the AMD driver is in fact the only one whose map/unmap
> callbacks aren't already spinlock-safe (or at least it was last time I was
> looking). Stuff like iommu-dma is already relying on this in order to
> implement streaming DMA API calls (which may be in atomic context) on top
> of the corresponding IOMMU API operations.
>
> Robin.
>

--0000000000009aa7c305743637e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The reason we want this change is so we can use iommu_grou=
p&#39;s to force our pcie devices to have the same IOMMU mappings. For lega=
cy reasons we require a bunch of our pcie devices to have the same address =
translation. <br><br> We were going to do this by using the iommu-dma api a=
nd replacing all the existing calls to . <br></div><div class=3D"gmail_extr=
a"><br><div class=3D"gmail_quote">On 24 August 2018 at 16:24, Robin Murphy =
<span dir=3D"ltr">&lt;<a href=3D"mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org" target=3D"_bl=
ank">robin.murphy-5wv7dgnIgG8@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On 24/08/18 15:53, Christoph=
 Hellwig wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Fri, Aug 24, 2018 at 02:28:49PM +0000, <a href=3D"mailto:murphyt7-/Zw1syy4LHg@public.gmane.org=
" target=3D"_blank">murphyt7-/Zw1syy4LHg@public.gmane.org</a> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Tom Murphy &lt;<a href=3D"mailto:murphyt7-/Zw1syy4LHg@public.gmane.org" target=3D"_blank">m=
urphyt7-/Zw1syy4LHg@public.gmane.org</a>&gt;<br>
<br>
---<br>
<br>
This patch allows the IOMMU API path in the AMD driver to be called from an=
 atomic context.<br>
This is useful for anyone building a driver which needs to call the IOMMU A=
PI while holding a spinlock.<br>
</blockquote>
<br>
I don&#39;t think that is a good idea.=C2=A0 Please point to the code in th=
e<br>
driver and we can&#39;t probably find a better solution.<br>
</blockquote>
<br></div></div>
Although IIRC the AMD driver is in fact the only one whose map/unmap callba=
cks aren&#39;t already spinlock-safe (or at least it was last time I was lo=
oking). Stuff like iommu-dma is already relying on this in order to impleme=
nt streaming DMA API calls (which may be in atomic context) on top of the c=
orresponding IOMMU API operations.<span class=3D"HOEnZb"><font color=3D"#88=
8888"><br>
<br>
Robin.<br>
</font></span></blockquote></div><br></div>

--0000000000009aa7c305743637e6--

--===============0718160895548011127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0718160895548011127==--
