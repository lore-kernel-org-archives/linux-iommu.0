From: Jitendra Bhivare via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [RFC 1/5] dt-bindings: iommu: Add reserved-dma-region for IOMMU
	device
Date: Mon, 12 Mar 2018 12:04:22 +0530
Message-ID: <CAOA9gs3NZt9hA8Ym+XgR+4z+BEW=YNJpQ628o7P=VEg0HTH95Q@mail.gmail.com>
References: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
	<1520312368-7068-2-git-send-email-jitendra.bhivare@broadcom.com>
	<23f7c879-2dfe-dbdf-f259-dcc44f045c96@arm.com>
Reply-To: Jitendra Bhivare <jitendra.bhivare-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6754305182804173284=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <23f7c879-2dfe-dbdf-f259-dcc44f045c96-5wv7dgnIgG8@public.gmane.org>
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
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============6754305182804173284==
Content-Type: multipart/alternative; boundary="001a1149750a22d1c40567315514"

--001a1149750a22d1c40567315514
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 6, 2018 at 5:11 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:

> On 06/03/18 04:59, Jitendra Bhivare wrote:
>
>> Certain regions in IO virtual address space may need to be reserved to be
>> not used for devices configured behind IOMMU.
>>
>> Add documentation of the property to allow such regions to be specified in
>> DT to be reserved using IOMMU_RESV_RESERVED type.
>>
>
> That sounds like software policy; DT is for describing hardware.

It is to describe the holes in address space for which hardware can't
provide mappings.

>
>
> Reviewed-by: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Signed-off-by: Jitendra Bhivare <jitendra.bhivare-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> ---
>>   Documentation/devicetree/bindings/iommu/iommu.txt | 17
>> +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt
>> b/Documentation/devicetree/bindings/iommu/iommu.txt
>> index 5a8b462..5a58ef2 100644
>> --- a/Documentation/devicetree/bindings/iommu/iommu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/iommu.txt
>> @@ -98,6 +98,20 @@ requirements of that use-case haven't been fully
>> determined yet. Implementing
>>   this is therefore not recommended without further discussion and
>> extension of
>>   this binding.
>>   +Optional properties:
>> +--------------------
>> +- reserved-dma-region: This specifies DMA region to be reserved with
>> specific
>> +  prot in IOVA space. It is in tuples of (busno,prot,bus_addr,size).
>>
>
> What do busno and prot actually mean, and what are valid values for them?

busno was part of initial commit 4e0ee78f in implementation of
of_get_dma_window.
I am not sure what was the use of it in Powerpc. Similar implementation can
be seen
in of_parse_dma_window.
prot is access permission flags for the region for reserving in SW.This I
will remove.

>
>
> Robin.
>
>
> +- #region-address-cells: specifies number of cells needed to encode
>> bus_addr
>> +
>> +- #region-size-cells: specifies number of cells needed to encode size
>> +
>> +Notes:
>> +======
>> +This can be applied to IOMMU master node or to children (such as PCI host
>> +bridges) on the bus behind IOMMU.
>> +
>>     Examples:
>>   =========
>> @@ -173,6 +187,9 @@ Multiple-master IOMMU with configurable DMA window:
>>                          * master (i.e. the I/O virtual address space).
>>                          */
>>                         #iommu-cells = <4>;
>> +                       #region-address-cells = <2>;
>> +                       #region-size-cells = <2>;
>> +                       reserved-dma-region = <0x0 0x0 0x04 0x0 0x04 0x0>;
>>                 };
>>                 master {
>>
>>

--001a1149750a22d1c40567315514
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Mar 6, 2018 at 5:11 PM, Robin Murphy <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:robin.murphy-5wv7dgnIgG8@public.gmane.org" target=3D"_blank">robin.murphy-5wv7dgnIgG8@public.gmane.org</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span cl=
ass=3D"gmail-">On 06/03/18 04:59, Jitendra Bhivare wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Certain regions in IO virtual address space may need to be reserved to be<b=
r>
not used for devices configured behind IOMMU.<br>
<br>
Add documentation of the property to allow such regions to be specified in<=
br>
DT to be reserved using IOMMU_RESV_RESERVED type.<br>
</blockquote>
<br></span>
That sounds like software policy; DT is for describing hardware.</blockquot=
e><div>It is to describe the holes in address space for which hardware can&=
#39;t provide mappings.=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><span class=3D"gmail-"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Reviewed-by: Ray Jui &lt;<a href=3D"mailto:ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" target=3D"=
_blank">ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org</a>&gt;<br>
Reviewed-by: Vikram Prakash &lt;<a href=3D"mailto:vikram.prakash@broadcom.c=
om" target=3D"_blank">vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org</a>&gt;<br>
Reviewed-by: Scott Branden &lt;<a href=3D"mailto:scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org=
" target=3D"_blank">scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org</a>&gt;<br>
Signed-off-by: Jitendra Bhivare &lt;<a href=3D"mailto:jitendra.bhivare@broa=
dcom.com" target=3D"_blank">jitendra.bhivare-dY08KVG/lbpWk0Htik3J/w@public.gmane.org</a><wbr>&gt;<br>
---<br>
=C2=A0 Documentation/devicetree/bindi<wbr>ngs/iommu/iommu.txt | 17 ++++++++=
+++++++++<br>
=C2=A0 1 file changed, 17 insertions(+)<br>
<br>
diff --git a/Documentation/devicetree/bin<wbr>dings/iommu/iommu.txt b/Docum=
entation/devicetree/bin<wbr>dings/iommu/iommu.txt<br>
index 5a8b462..5a58ef2 100644<br>
--- a/Documentation/devicetree/bin<wbr>dings/iommu/iommu.txt<br>
+++ b/Documentation/devicetree/bin<wbr>dings/iommu/iommu.txt<br>
@@ -98,6 +98,20 @@ requirements of that use-case haven&#39;t been fully det=
ermined yet. Implementing<br>
=C2=A0 this is therefore not recommended without further discussion and ext=
ension of<br>
=C2=A0 this binding.<br>
=C2=A0 +Optional properties:<br>
+--------------------<br>
+- reserved-dma-region: This specifies DMA region to be reserved with speci=
fic<br>
+=C2=A0 prot in IOVA space. It is in tuples of (busno,prot,bus_addr,size).<=
br>
</blockquote>
<br></span>
What do busno and prot actually mean, and what are valid values for them?</=
blockquote><div>busno was part of initial commit 4e0ee78f in implementation=
 of of_get_dma_window.</div><div>I am not sure what was the use of it in Po=
werpc. Similar implementation can be seen<br></div><div>in of_parse_dma_win=
dow.</div><div>prot is access permission flags for the region for reserving=
 in SW.This I will remove.</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
<br>
Robin.</font></span><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br=
>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+- #region-address-cells: specifies number of cells needed to encode bus_ad=
dr<br>
+<br>
+- #region-size-cells: specifies number of cells needed to encode size<br>
+<br>
+Notes:<br>
+=3D=3D=3D=3D=3D=3D<br>
+This can be applied to IOMMU master node or to children (such as PCI host<=
br>
+bridges) on the bus behind IOMMU.<br>
+<br>
=C2=A0 =C2=A0 Examples:<br>
=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
@@ -173,6 +187,9 @@ Multiple-master IOMMU with configurable DMA window:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* master (i.e. the I/O virtual address space).<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 #iommu-cells =3D &lt;4&gt;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0#region-address-cells =3D &lt;2&gt;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0#region-size-cells =3D &lt;2&gt;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0reserved-dma-region =3D &lt;0x0 0x0 0x04 0x0 0x04 0x0&gt;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 master {<br>
<br>
</blockquote>
</div></div></blockquote></div><br></div></div>

--001a1149750a22d1c40567315514--

--===============6754305182804173284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6754305182804173284==--
