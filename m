From: James Sewart via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [RFC] iommu/vt-d: Group and domain relationship
Date: Mon, 12 Nov 2018 11:15:19 +0000
Message-ID: <C5F6BA1D-F39D-4CC7-A487-01C5C5C206B0@arista.com>
References: <44573340-5652-42F1-A4B8-102AEF5C162A@arista.com>
	<5695aa18-3248-b611-a286-111de7e5a8f5@linux.intel.com>
	<CALwnD_qUhQu-fwOObth-DWzSNoARZ_ERuNwyS8r73C0yhw7jGQ@mail.gmail.com>
	<b92b1739-dc3e-9515-a6f1-e4c00f53882b@linux.intel.com>
	<A393DB8A-BFC6-40C2-B9E8-6667A927957E@arista.com>
	<14cb4192-8557-72e1-ef26-4155b2cd7e63@linux.intel.com>
	<9B06CA0B-A5F8-41FC-8F5E-6D7BE94FCC14@arista.com>
	<20181109110901.4fec1bb1@jacob-builder>
Reply-To: James Sewart <jamessewart-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: multipart/mixed; boundary="===============0579245629078923774=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181109110901.4fec1bb1@jacob-builder>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============0579245629078923774==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_BA42D696-0844-4837-B98D-672B4969322C"


--Apple-Mail=_BA42D696-0844-4837-B98D-672B4969322C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hey Jacob,

> On 9 Nov 2018, at 19:09, Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> =
wrote:
>=20
> On Thu, 8 Nov 2018 11:30:04 +0000
> James Sewart <jamessewart-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org <mailto:jamessewart-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>> =
wrote:
>=20
>> Hey,
>>=20
>>> On 8 Nov 2018, at 01:42, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>>=20
>>> Hi,
>>>=20
>>> On 11/8/18 1:55 AM, James Sewart wrote: =20
>>>> Hey, =20
>>>>> On 7 Nov 2018, at 02:10, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>>>> wrote:
>>>>>=20
>>>>> Hi,
>>>>>=20
>>>>> On 11/6/18 6:40 PM, James Sewart wrote: =20
>>>>>> Hey Lu,
>>>>>> Would you be able to go into more detail about the issues with
>>>>>> allowing IOMMU_DOMAIN_DMA to be allocated via domain_alloc? =20
>>>>>=20
>>>>> This door is closed because intel iommu driver does everything for
>>>>> IOMMU_DOMAIN_DMA: allocating a domain and setup the context
>>>>> entries for the domain. =20
>>>> As far as I can tell, attach_device in the intel driver will handle
>>>> cleaning up any old domain context mapping and ensure the new
>>>> domain is mapped with calls to dmar_remove_one_dev_info and
>>>> domain_add_dev_info. =20
>>>=20
>>> That's only for domains of IOMMU_DOMAIN_UNMANAGED, right? =20
>>=20
>> attach_device has logic for cleaning up domains that are allocated by
>> the intel driver.
>>=20
>> 		old_domain =3D find_domain(dev);
>> 		if (old_domain) {
>> 			rcu_read_lock();
>> 			dmar_remove_one_dev_info(old_domain, dev);
>> 			rcu_read_unlock();
>>=20
>> 			if (!domain_type_is_vm_or_si(old_domain) &&
>> 			     list_empty(&old_domain->devices))
>> 				domain_exit(old_domain);
>> 		}
>>=20
>> This is checking the type of the old domain only, freeing it if is
>> not attached to any devices. Looking at this now, maybe the solution
>> would be to distinguish between internally allocated dma domains and
>> dma domains allocated via the external api, so we avoid freeing a
>> domain a driver has reference to.
>>=20
> I think this can also be solved by adopting default domain and moving
> internal domain to the generic code at group level. i.e. when device =
is
> added to a group, the group gets a default domain (also set as current
> domain) for DMA APIs. When device is attached to an unmanaged domain
> (VFIO container and IOMMU API), it will switch the current domain to
> the new domain. Old domain will be inactive but not exited.
>>>>>=20
>>>>> Why do we want to open this door? Probably we want the generic
>>>>> iommu layer to handle these things (it's called default domain). =20=

>>>> I=E2=80=99d like to allocate a domain and attach it to multiple =
devices in
>>>> a group/multiple groups so that they share address translation,
>>>> but still allow drivers for devices in those groups to use the
>>>> dma_map_ops api. =20
>>>=20
>>> Just out of curiosity, why do you want to share a single domain
>>> across multiple groups? By default, the groups and DMA domains are
>>> normally 1-1 mapped, right? =20
>>=20
>> Currently we see each device in a group with their own domain.=20
>> find_or_alloc_domain looks at dma aliases to determine who shares
>> domains whereas pci_device_group in the generic iommu code determines
>> groups using a few other checks. We have observed internally that
>> devices under a pcie switch will be put in the same group but they do
>> not share a domain within that group.
>>=20
>> Getting every device within a group to share a domain would get us
>> 90% of the way to what we want. But we have some configurations where
>> there exist devices put in other groups that we want to share
>> translations with.
>>=20
> This is indeed a huge disconnect between IOMMU API and VT-d handling
> of the DMA API. IOMMU API operates at group granu (per group domain)
> that is based on ACS whereas DMA API in VT-d has per device domain and
> sharing is not based on ACS. So I agree you could have multiple =
domains
> under the same group for DMA API use.
>=20
> I am working on a patch to align the two, e.g. use per group
> default domain for DMA APIs. My idea is as follows:
> - support DOMAIN_DMA type in intel_iommu_domain_alloc()
> - add device to group will attach to the default DMA domain
> 	- have to inherit any RMRR or identity mapping holes set up
> 	  prior to IOMMU group setup.
> 	- Or perhaps implement apply_resv_region() in VT-d driver and
> 	  move RMRR setup here.
> - DMA map API, will use per group default domain instead of per device
>  private domain
>=20
> The change is rather pervasive so i am trying to set a balance for
> short term functionality and complete clean up. Any ideas welcome.
>=20

Sounds good, thanks. I am eager to test the patch.

>>>=20
>>>>> So we can't just open the door but not cleanup the things right? =20=

>>>> A user of domain_alloc and attach_device is responsible for
>>>> detaching a domain if it is no longer needed and calling
>>>> domain_free. =20
>>>=20
>>> Currently DMA API calls get_valid_domain_for_dev() to retrieve a DMA
>>> domain. If the domain has already been allocated, return directly.
>>> Otherwise, allocate and initialize a new one for the device. Let's
>>> call domains allocated by get_valid_domain_for_dev() as "A".
>>>=20
>>> If we open the door and allow another component to manage the DMA
>>> domains through domain iommu_domain_alloc/free(). Let's call domains
>>> allocated through iommu_domain_alloc() as "B".
>>>=20
>>> So how can we sync between A and B? =20
>>=20
>> I=E2=80=99m not sure we need to sync them. Domain A would be replaced
>> entirely for a certain device with domain B by attach_device. As we
>> saw above domain A would be freed if there are no more devices
>> attached to it. Domain B would be managed by the user of the iommu
>> api. If a device is detached from domain B, the find_or_alloc_domain
>> logic will take over once more and allocate a fresh domain.
>>=20
> Agreed, it is more like switching domains when you switching APIs. But
> the reserved region better be preserved.
>> Cheers,
>> James.
>>=20
>>>=20
>>> Need to go through the code to find out more.
>>>=20
>>> Best regards,
>>> Lu Baolu =20
>>>> Cheers,
>>>> James. =20
>>>>>=20
>>>>> I haven't spent time on details. So I cc'ed Jacob for corrections.
>>>>>=20
>>>>> Best regards,
>>>>> Lu Baolu
>>>>>=20
>>>>>> Cheers,
>>>>>> James.
>>>>>> On Fri, Nov 2, 2018 at 2:43 AM Lu Baolu
>>>>>> <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote: =20
>>>>>>>=20
>>>>>>> Hi,
>>>>>>>=20
>>>>>>> On 10/30/18 10:18 PM, James Sewart via iommu wrote: =20
>>>>>>>> Hey,
>>>>>>>>=20
>>>>>>>> I=E2=80=99ve been investigating the relationship between iommu =
groups
>>>>>>>> and domains on our systems and have a few question. Why does
>>>>>>>> the intel iommu code not allow allocating IOMMU_DOMAIN_DMA?
>>>>>>>> Returning NULL when given this domain type has the side effect
>>>>>>>> that the default_domain for an iommu group is not set, which,
>>>>>>>> when using for e.g. dma_map_ops.map_page, means a domain is
>>>>>>>> allocated per device. =20
>>>>>>>=20
>>>>>>> Intel vt-d driver doesn't implement the default domain and
>>>>>>> allocates domain only on demanded. There are lots of things to
>>>>>>> do before we allow iommu API to allocate domains other than
>>>>>>> IOMMU_DOMAIN_UNMANAGED.
>>>>>>>=20
>>>>>>> Best regards,
>>>>>>> Lu Baolu
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> This seems to be the opposite behaviour to the AMD iommu code
>>>>>>>> which supports allocating an IOMMU_DOMAIN_DMA and will only
>>>>>>>> look to the iommu group if a domain is not attached to the
>>>>>>>> device rather than allocating a new one. On AMD every device
>>>>>>>> in an iommu group will share the same domain.
>>>>>>>>=20
>>>>>>>> Appended is what I think a patch to implement domain_alloc for
>>>>>>>> IOMMU_DOMAIN_DMA and also IOMMU_DOMAIN_IDENTITY would look
>>>>>>>> like. Testing shows each device in a group will share a domain
>>>>>>>> by default, it also allows allocating a new dma domain that
>>>>>>>> can be successfully attached to a group with
>>>>>>>> iommu_attach_group.
>>>>>>>>=20
>>>>>>>> Looking for comment on why the behaviour is how it is
>>>>>>>> currently and if there are any issues with the solution I=E2=80=99=
ve
>>>>>>>> been testing.
>>>>>>>>=20
>>>>>>>> Cheers,
>>>>>>>> James.
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> diff --git a/drivers/iommu/intel-iommu.c
>>>>>>>> b/drivers/iommu/intel-iommu.c index bff2abd6..3a58389f 100644
>>>>>>>> --- a/drivers/iommu/intel-iommu.c
>>>>>>>> +++ b/drivers/iommu/intel-iommu.c
>>>>>>>> @@ -5170,10 +5170,15 @@ static struct iommu_domain
>>>>>>>> *intel_iommu_domain_alloc(unsigned type) struct dmar_domain
>>>>>>>> *dmar_domain; struct iommu_domain *domain;
>>>>>>>>=20
>>>>>>>> -     if (type !=3D IOMMU_DOMAIN_UNMANAGED)
>>>>>>>> +     if (type =3D=3D IOMMU_DOMAIN_UNMANAGED)
>>>>>>>> +             dmar_domain =3D
>>>>>>>> alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
>>>>>>>> +     else if(type =3D=3D IOMMU_DOMAIN_DMA)
>>>>>>>> +             dmar_domain =3D alloc_domain(0);
>>>>>>>> +     else if(type =3D=3D IOMMU_DOMAIN_IDENTITY)
>>>>>>>> +             dmar_domain =3D
>>>>>>>> alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
>>>>>>>> +     else
>>>>>>>>              return NULL;
>>>>>>>>=20
>>>>>>>> -     dmar_domain =3D =
alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
>>>>>>>>      if (!dmar_domain) {
>>>>>>>>              pr_err("Can't allocate dmar_domain\n");
>>>>>>>>              return NULL;
>>>>>>>> @@ -5186,9 +5191,12 @@ static struct iommu_domain
>>>>>>>> *intel_iommu_domain_alloc(unsigned type)
>>>>>>>> domain_update_iommu_cap(dmar_domain);
>>>>>>>>=20
>>>>>>>>      domain =3D &dmar_domain->domain;
>>>>>>>> -     domain->geometry.aperture_start =3D 0;
>>>>>>>> -     domain->geometry.aperture_end   =3D
>>>>>>>> __DOMAIN_MAX_ADDR(dmar_domain->gaw);
>>>>>>>> -     domain->geometry.force_aperture =3D true;
>>>>>>>> +
>>>>>>>> +     if (type =3D=3D IOMMU_DOMAIN_UNMANAGED) {
>>>>>>>> +             domain->geometry.aperture_start =3D 0;
>>>>>>>> +             domain->geometry.aperture_end   =3D
>>>>>>>> __DOMAIN_MAX_ADDR(dmar_domain->gaw);
>>>>>>>> +             domain->geometry.force_aperture =3D true;
>>>>>>>> +     }
>>>>>>>>=20
>>>>>>>>      return domain;
>>>>>>>>  }
>>>>>>>> _______________________________________________
>>>>>>>> iommu mailing list
>>>>>>>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>>>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>>>>>>>=20
>>=20
>=20
> [Jacob Pan]


--Apple-Mail=_BA42D696-0844-4837-B98D-672B4969322C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D"">Hey =
Jacob,<br class=3D""><div><br class=3D""><blockquote type=3D"cite" =
class=3D""><div class=3D"">On 9 Nov 2018, at 19:09, Jacob Pan &lt;<a =
href=3D"mailto:jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" =
class=3D"">jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">On Thu, 8 Nov 2018 11:30:04 =
+0000</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">James Sewart &lt;</span><a =
href=3D"mailto:jamessewart-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" =
class=3D"">jamessewart-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org</a><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">&gt; wrote:</span><br style=3D"font-family:=
 Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">Hey,<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">On 8 Nov 2018, at 01:42, =
Lu Baolu &lt;<a href=3D"mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" =
class=3D"">baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org</a>&gt; wrote:<br class=3D""><br =
class=3D"">Hi,<br class=3D""><br class=3D"">On 11/8/18 1:55 AM, James =
Sewart wrote: &nbsp;<br class=3D""><blockquote type=3D"cite" =
class=3D"">Hey, &nbsp;<br class=3D""><blockquote type=3D"cite" =
class=3D"">On 7 Nov 2018, at 02:10, Lu Baolu &lt;<a =
href=3D"mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" =
class=3D"">baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org</a>&gt;<br class=3D"">wrote:<br =
class=3D""><br class=3D"">Hi,<br class=3D""><br class=3D"">On 11/6/18 =
6:40 PM, James Sewart wrote: &nbsp;<br class=3D""><blockquote =
type=3D"cite" class=3D"">Hey Lu,<br class=3D"">Would you be able to go =
into more detail about the issues with<br class=3D"">allowing =
IOMMU_DOMAIN_DMA to be allocated via domain_alloc? &nbsp;<br =
class=3D""></blockquote><br class=3D"">This door is closed because intel =
iommu driver does everything for<br class=3D"">IOMMU_DOMAIN_DMA: =
allocating a domain and setup the context<br class=3D"">entries for the =
domain. &nbsp;<br class=3D""></blockquote>As far as I can tell, =
attach_device in the intel driver will handle<br class=3D"">cleaning up =
any old domain context mapping and ensure the new<br class=3D"">domain =
is mapped with calls to dmar_remove_one_dev_info and<br =
class=3D"">domain_add_dev_info. &nbsp;<br class=3D""></blockquote><br =
class=3D"">That's only for domains of IOMMU_DOMAIN_UNMANAGED, right? =
&nbsp;<br class=3D""></blockquote><br class=3D"">attach_device has logic =
for cleaning up domains that are allocated by<br class=3D"">the intel =
driver.<br class=3D""><br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>old_domain =3D =
find_domain(dev);<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (old_domain) {<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>rcu_read_lock();<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>dmar_remove_one_dev_info(old_domain, dev);<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>rcu_read_unlock();<br class=3D""><br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(!domain_type_is_vm_or_si(old_domain) &amp;&amp;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;list_=
empty(&amp;old_domain-&gt;devices))<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>domain_exit(old_domain);<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>}<br =
class=3D""><br class=3D"">This is checking the type of the old domain =
only, freeing it if is<br class=3D"">not attached to any devices. =
Looking at this now, maybe the solution<br class=3D"">would be to =
distinguish between internally allocated dma domains and<br class=3D"">dma=
 domains allocated via the external api, so we avoid freeing a<br =
class=3D"">domain a driver has reference to.<br class=3D""><br =
class=3D""></blockquote><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">I think this can also be solved by =
adopting default domain and moving</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">internal domain to the generic =
code at group level. i.e. when device is</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">added to a group, the group gets =
a default domain (also set as current</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">domain) for DMA APIs. When =
device is attached to an unmanaged domain</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">(VFIO container and IOMMU API), =
it will switch the current domain to</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">the new domain. Old domain will =
be inactive but not exited.</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><blockquote type=3D"cite" =
class=3D""><blockquote type=3D"cite" class=3D""><blockquote type=3D"cite" =
class=3D""><br class=3D"">Why do we want to open this door? Probably we =
want the generic<br class=3D"">iommu layer to handle these things (it's =
called default domain). &nbsp;<br class=3D""></blockquote>I=E2=80=99d =
like to allocate a domain and attach it to multiple devices in<br =
class=3D"">a group/multiple groups so that they share address =
translation,<br class=3D"">but still allow drivers for devices in those =
groups to use the<br class=3D"">dma_map_ops api. &nbsp;<br =
class=3D""></blockquote><br class=3D"">Just out of curiosity, why do you =
want to share a single domain<br class=3D"">across multiple groups? By =
default, the groups and DMA domains are<br class=3D"">normally 1-1 =
mapped, right? &nbsp;<br class=3D""></blockquote><br class=3D"">Currently =
we see each device in a group with their own domain.<span =
class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D"">find_or_alloc_domain looks at dma aliases to determine who =
shares<br class=3D"">domains whereas pci_device_group in the generic =
iommu code determines<br class=3D"">groups using a few other checks. We =
have observed internally that<br class=3D"">devices under a pcie switch =
will be put in the same group but they do<br class=3D"">not share a =
domain within that group.<br class=3D""><br class=3D"">Getting every =
device within a group to share a domain would get us<br class=3D"">90% =
of the way to what we want. But we have some configurations where<br =
class=3D"">there exist devices put in other groups that we want to =
share<br class=3D"">translations with.<br class=3D""><br =
class=3D""></blockquote><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">This is indeed a huge disconnect between =
IOMMU API and VT-d handling</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">of the DMA API. IOMMU API =
operates at group granu (per group domain)</span><br style=3D"font-family:=
 Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">that is based on ACS whereas DMA =
API in VT-d has per device domain and</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">sharing is not based on ACS. So =
I agree you could have multiple domains</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">under the same group for DMA API =
use.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">I am working on a patch to align =
the two, e.g. use per group</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">default domain for DMA APIs. My =
idea is as follows:</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">- support DOMAIN_DMA type in =
intel_iommu_domain_alloc()</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">- add device to group will =
attach to the default DMA domain</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: pre; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">	</span><span style=3D"font-family:=
 Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">- have to inherit any RMRR or identity =
mapping holes set up</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: pre; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">	</span><span style=3D"font-family:=
 Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;prior to IOMMU group =
setup.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span class=3D"Apple-tab-span"=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">- Or perhaps implement apply_resv_region() in =
VT-d driver and</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span class=3D"Apple-tab-span"=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;move RMRR setup =
here.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">- DMA map API, will use per group default =
domain instead of per device</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">&nbsp;private domain</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">The change is rather pervasive so i am trying to =
set a balance for</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">short term functionality and complete =
clean up. Any ideas welcome.</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br class=3D""></div><div>Sounds =
good, thanks. I am eager to test the patch.</div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><blockquote type=3D"cite" =
class=3D""><br class=3D""><blockquote type=3D"cite" class=3D""><blockquote=
 type=3D"cite" class=3D"">So we can't just open the door but not cleanup =
the things right? &nbsp;<br class=3D""></blockquote>A user of =
domain_alloc and attach_device is responsible for<br class=3D"">detaching =
a domain if it is no longer needed and calling<br class=3D"">domain_free. =
&nbsp;<br class=3D""></blockquote><br class=3D"">Currently DMA API calls =
get_valid_domain_for_dev() to retrieve a DMA<br class=3D"">domain. If =
the domain has already been allocated, return directly.<br =
class=3D"">Otherwise, allocate and initialize a new one for the device. =
Let's<br class=3D"">call domains allocated by get_valid_domain_for_dev() =
as "A".<br class=3D""><br class=3D"">If we open the door and allow =
another component to manage the DMA<br class=3D"">domains through domain =
iommu_domain_alloc/free(). Let's call domains<br class=3D"">allocated =
through iommu_domain_alloc() as "B".<br class=3D""><br class=3D"">So how =
can we sync between A and B? &nbsp;<br class=3D""></blockquote><br =
class=3D"">I=E2=80=99m not sure we need to sync them. Domain A would be =
replaced<br class=3D"">entirely for a certain device with domain B by =
attach_device. As we<br class=3D"">saw above domain A would be freed if =
there are no more devices<br class=3D"">attached to it. Domain B would =
be managed by the user of the iommu<br class=3D"">api. If a device is =
detached from domain B, the find_or_alloc_domain<br class=3D"">logic =
will take over once more and allocate a fresh domain.<br class=3D""><br =
class=3D""></blockquote><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">Agreed, it is more like switching domains =
when you switching APIs. But</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">the reserved region better be =
preserved.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" =
class=3D"">Cheers,<br class=3D"">James.<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">Need to =
go through the code to find out more.<br class=3D""><br class=3D"">Best =
regards,<br class=3D"">Lu Baolu &nbsp;<br class=3D""><blockquote =
type=3D"cite" class=3D"">Cheers,<br class=3D"">James. &nbsp;<br =
class=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">I haven't =
spent time on details. So I cc'ed Jacob for corrections.<br class=3D""><br=
 class=3D"">Best regards,<br class=3D"">Lu Baolu<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">Cheers,<br =
class=3D"">James.<br class=3D"">On Fri, Nov 2, 2018 at 2:43 AM Lu =
Baolu<br class=3D"">&lt;<a href=3D"mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" =
class=3D"">baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org</a>&gt; wrote: &nbsp;<br =
class=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">Hi,<br =
class=3D""><br class=3D"">On 10/30/18 10:18 PM, James Sewart via iommu =
wrote: &nbsp;<br class=3D""><blockquote type=3D"cite" class=3D"">Hey,<br =
class=3D""><br class=3D"">I=E2=80=99ve been investigating the =
relationship between iommu groups<br class=3D"">and domains on our =
systems and have a few question. Why does<br class=3D"">the intel iommu =
code not allow allocating IOMMU_DOMAIN_DMA?<br class=3D"">Returning NULL =
when given this domain type has the side effect<br class=3D"">that the =
default_domain for an iommu group is not set, which,<br class=3D"">when =
using for e.g. dma_map_ops.map_page, means a domain is<br =
class=3D"">allocated per device. &nbsp;<br class=3D""></blockquote><br =
class=3D"">Intel vt-d driver doesn't implement the default domain and<br =
class=3D"">allocates domain only on demanded. There are lots of things =
to<br class=3D"">do before we allow iommu API to allocate domains other =
than<br class=3D"">IOMMU_DOMAIN_UNMANAGED.<br class=3D""><br =
class=3D"">Best regards,<br class=3D"">Lu Baolu<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">This =
seems to be the opposite behaviour to the AMD iommu code<br =
class=3D"">which supports allocating an IOMMU_DOMAIN_DMA and will =
only<br class=3D"">look to the iommu group if a domain is not attached =
to the<br class=3D"">device rather than allocating a new one. On AMD =
every device<br class=3D"">in an iommu group will share the same =
domain.<br class=3D""><br class=3D"">Appended is what I think a patch to =
implement domain_alloc for<br class=3D"">IOMMU_DOMAIN_DMA and also =
IOMMU_DOMAIN_IDENTITY would look<br class=3D"">like. Testing shows each =
device in a group will share a domain<br class=3D"">by default, it also =
allows allocating a new dma domain that<br class=3D"">can be =
successfully attached to a group with<br class=3D"">iommu_attach_group.<br=
 class=3D""><br class=3D"">Looking for comment on why the behaviour is =
how it is<br class=3D"">currently and if there are any issues with the =
solution I=E2=80=99ve<br class=3D"">been testing.<br class=3D""><br =
class=3D"">Cheers,<br class=3D"">James.<br class=3D""><br class=3D""><br =
class=3D"">diff --git a/drivers/iommu/intel-iommu.c<br =
class=3D"">b/drivers/iommu/intel-iommu.c index bff2abd6..3a58389f =
100644<br class=3D"">--- a/drivers/iommu/intel-iommu.c<br class=3D"">+++ =
b/drivers/iommu/intel-iommu.c<br class=3D"">@@ -5170,10 +5170,15 @@ =
static struct iommu_domain<br =
class=3D"">*intel_iommu_domain_alloc(unsigned type) struct =
dmar_domain<br class=3D"">*dmar_domain; struct iommu_domain *domain;<br =
class=3D""><br class=3D"">- &nbsp;&nbsp;&nbsp;&nbsp;if (type !=3D =
IOMMU_DOMAIN_UNMANAGED)<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;if (type =
=3D=3D IOMMU_DOMAIN_UNMANAGED)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dm=
ar_domain =3D<br class=3D"">alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;else if(type =3D=3D =
IOMMU_DOMAIN_DMA)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dm=
ar_domain =3D alloc_domain(0);<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;else if(type =3D=3D IOMMU_DOMAIN_IDENTITY)<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dm=
ar_domain =3D<br class=3D"">alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;else<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;return NULL;<br class=3D""><br class=3D"">- =
&nbsp;&nbsp;&nbsp;&nbsp;dmar_domain =3D =
alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!dmar_domain) {<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;pr_err("Can't allocate dmar_domain\n");<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;return NULL;<br class=3D"">@@ -5186,9 +5191,12 @@ static =
struct iommu_domain<br class=3D"">*intel_iommu_domain_alloc(unsigned =
type)<br class=3D"">domain_update_iommu_cap(dmar_domain);<br =
class=3D""><br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;domain =3D =
&amp;dmar_domain-&gt;domain;<br class=3D"">- =
&nbsp;&nbsp;&nbsp;&nbsp;domain-&gt;geometry.aperture_start =3D 0;<br =
class=3D"">- &nbsp;&nbsp;&nbsp;&nbsp;domain-&gt;geometry.aperture_end =
&nbsp;&nbsp;=3D<br class=3D"">__DOMAIN_MAX_ADDR(dmar_domain-&gt;gaw);<br =
class=3D"">- &nbsp;&nbsp;&nbsp;&nbsp;domain-&gt;geometry.force_aperture =
=3D true;<br class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;if =
(type =3D=3D IOMMU_DOMAIN_UNMANAGED) {<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;do=
main-&gt;geometry.aperture_start =3D 0;<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;do=
main-&gt;geometry.aperture_end &nbsp;&nbsp;=3D<br =
class=3D"">__DOMAIN_MAX_ADDR(dmar_domain-&gt;gaw);<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;do=
main-&gt;geometry.force_aperture =3D true;<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;}<br class=3D""><br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return domain;<br =
class=3D"">&nbsp;}<br =
class=3D"">_______________________________________________<br =
class=3D"">iommu mailing list<br class=3D""><a =
href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" =
class=3D"">iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a><br =
class=3D"">https://lists.linuxfoundation.org/mailman/listinfo/iommu<br =
class=3D""><br =
class=3D""></blockquote></blockquote></blockquote></blockquote></blockquot=
e></blockquote><br class=3D""></blockquote><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">[Jacob =
Pan]</span></div></blockquote></div><br class=3D""></body></html>=

--Apple-Mail=_BA42D696-0844-4837-B98D-672B4969322C--

--===============0579245629078923774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0579245629078923774==--
