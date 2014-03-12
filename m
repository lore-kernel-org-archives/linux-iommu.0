From: "Sumner, William" <bill.sumner-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCHv3 0/6] Crashdump Accepting Active IOMMU
Date: Wed, 12 Mar 2014 16:15:10 +0000
Message-ID: <875D89B79D1D86448A583A7302C022A066E09397@G4W3212.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5880647866108602385=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, "Hatch,
	Douglas B (HPS Linux PM)" <doug.hatch-VXdhtT5mjnY@public.gmane.org>, "ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org" <ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============5880647866108602385==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_875D89B79D1D86448A583A7302C022A066E09397G4W3212americas_"

--_000_875D89B79D1D86448A583A7302C022A066E09397G4W3212americas_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2014 at 04:43PM, Vivek Goyal wrote:
>On Fri, Jan 10, 2014 at 03:07:26PM -0700, Bill Sumner wrote:
>
>[..]
>> This patch set modifies the behavior of the iommu in the (new) crashdump=
 kernel:
>> 1. to accept the iommu hardware in an active state, 2. to leave the
>> current translations in-place so that legacy DMA will continue
>>    using its current buffers until the device drivers in the crashdump k=
ernel>>    initialize and initialize their devices, 3. to use different
>> portions of the iova address ranges for the device drivers
>>    in the crashdump kernel than the iova ranges that were in-use at the =
time
>>    of the panic.
>
>Conceptually, above makes sense to me. I have few queries.
>
>- Do we need to pass any kind of data from first kernel to second kernel,
>  like table size etc? Calgary IOMMU was using first kernel's tables
>  also and it was determining previous kernel's table size using saved_max=
_pfn.

Yes. We need to pass the intel-iommu translation tables from the first kern=
el to the second kernel - well, to allow the second kernel to read them.  O=
nly the tree of tables that the intel-iommu hardware references are needed:=
 the root-entry table, the context-entry tables, and the page-translation t=
ables.  This patch involves only the intel-iommu -- and none of the other i=
ommu hardware types.

During the early initialization of the new kdump kernel this patch copies (=
duplicates) the tree of iommu translation tables from the old kernel into t=
he new kernel.  These tables are all linked together as a tree by physical =
memory addresses. The physical address of the top of the tree -- the root-e=
ntry table -- is obtained from a register in the iommu hardware. The copy o=
peration traverses the tree in depth-first order, sanity-checking each tabl=
e and then duplicating it into the kernel address space of the new kernel, =
linking the new tables appropriately.  If the copy succeeds then the iommu =
register is updated to point to the copy in the new kernel and the iommu co=
ntinues translating DMA requests from IO devices.  If a sanity-check fails,=
 the patch currently errors-out of the dump (might want to revisit this err=
or case and see if there is something better to do.)

By copying the tables into the new kernel, all of the existing code in inte=
l-iommu.c continues to work nearly unchanged, with only a few added initial=
izations of fields when kdump is active and when intel-iommu.c creates its =
"bookkeeping" structures for the device -- to make sure they correspond to =
the contents of the translate tables. I made a determined effort to avoid c=
hanging the existing execution path for the non-kdump case, and to minimize=
 the changes even when kdump is active.

Note also that this leaves the copy of the translate tables in the old pani=
cked kernel unused and unchanged during the operation of 'makedumpfile', so=
 they appear correctly in the dump as they were at the time of the panic.

>
>- I don't know how IOMMU translation tables look like, but are new DMA
>  zones setup by drivers in second kernel part of same table?

Yes. The copied translation tables in the kdump kernel contain both the tra=
nslations that were active at the time of the dump (which will never go awa=
y until the dump is finished and the platform is rebooted), plus any transl=
ations needed by the kdump kernel (which come and go as necessary).  As the=
 "bookkeeping" structures are created in the new kernel (typically the firs=
t time that a device requests a translation for a buffer) they are initiali=
zed such that all IOVAs that already exist in the translate tables for tht =
device are marked as "not available for allocation" so all requests by devi=
ce drivers in the new kernel receive IOVAs that were not in-use at the time=
 of the panic.

> How do we
>  make sure that sufficient space is available.

So far I have not seen any problem with running out of space because of thi=
s copy;  however, I believe that this may be a valid concern with very larg=
e IO configurations -- and it deserves some attention as the community revi=
ews and tests this patch.

> I am not sure if possible
>  table corruption from crashed kernel is an issue here or not.

Any corrupted translation tables from the crashed kernel would be a problem=
 that would prevent using copies of them. I hope and expect that this happe=
ns rarely -- and that we would catch it during the copy when it does.

Fortunately, these tables are only manipulated by the code in intel-iommu.c=
 - which limits the amount of code that has to be "right".  Of course, ther=
e is always the possibility that other code in the kernel could "hose" one =
of these tables -- so we need to sanity-check the tables before the new ker=
nel uses them.

>
>In general, I think changelogs of these patches need to be little better.
>There seem to be lot of text and still I can't quickly wrap my head around=
 what a particular patch is supposed to be doing.

I will work on the changelogs as I re-arrange the code and the structure of=
 the patch-set for the next submitted version.

>
>But we definitely need to fix this issue. IOMMU issues with kdump have bee=
n troubling us for a very long time.
Strongly agree.

-- Bill

--_000_875D89B79D1D86448A583A7302C022A066E09397G4W3212americas_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">On Mon, Mar 10, 2014 at 04:43PM, Vivek Goyal wrote:<=
o:p></o:p></p>
<p class=3D"MsoNormal">&gt;On Fri, Jan 10, 2014 at 03:07:26PM -0700, Bill S=
umner wrote:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;[..]<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; This patch set modifies the behavior of the=
 iommu in the (new) crashdump kernel:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; 1. to accept the iommu hardware in an activ=
e state, 2. to leave the<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; current translations in-place so that legac=
y DMA will continue<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;&nbsp;&nbsp; using its current buffers=
 until the device drivers in the crashdump kernel&gt;&gt;&nbsp;&nbsp;&nbsp;=
 initialize and initialize their devices, 3. to use different<o:p></o:p></p=
>
<p class=3D"MsoNormal">&gt;&gt; portions of the iova address ranges for the=
 device drivers<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;&nbsp;&nbsp; in the crashdump kernel t=
han the iova ranges that were in-use at the time<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;&nbsp;&nbsp; of the panic.<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;Conceptually, above makes sense to me. I have fe=
w queries.<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;- Do we need to pass any kind of data from first=
 kernel to second kernel,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&nbsp; like table size etc? Calgary IOMMU was us=
ing first kernel's tables<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&nbsp; also and it was determining previous kern=
el's table size using saved_max_pfn.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Yes. We need to pass the intel-iommu translation tab=
les from the first kernel to the second kernel &#8211; well, to allow the s=
econd kernel to read them.&nbsp; Only the tree of tables that the intel-iom=
mu hardware references are needed: the root-entry
 table, the context-entry tables, and the page-translation tables.&nbsp; Th=
is patch involves only the intel-iommu -- and none of the other iommu hardw=
are types.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">During the early initialization of the new kdump ker=
nel this patch copies (duplicates) the tree of iommu translation tables fro=
m the old kernel into the new kernel.&nbsp; These tables are all linked tog=
ether as a tree by physical memory addresses.
 The physical address of the top of the tree -- the root-entry table -- is =
obtained from a register in the iommu hardware. The copy operation traverse=
s the tree in depth-first order, sanity-checking each table and then duplic=
ating it into the kernel address
 space of the new kernel, linking the new tables appropriately.&nbsp; If th=
e copy succeeds then the iommu register is updated to point to the copy in =
the new kernel and the iommu continues translating DMA requests from IO dev=
ices.&nbsp; If a sanity-check fails, the patch
 currently errors-out of the dump (might want to revisit this error case an=
d see if there is something better to do.)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">By copying the tables into the new kernel, all of th=
e existing code in intel-iommu.c continues to work nearly unchanged, with o=
nly a few added initializations of fields when kdump is active and when int=
el-iommu.c creates its &quot;bookkeeping&quot;
 structures for the device -- to make sure they correspond to the contents =
of the translate tables. I made a determined effort to avoid changing the e=
xisting execution path for the non-kdump case, and to minimize the changes =
even when kdump is active.&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Note also that this leaves the copy of the translate=
 tables in the old panicked kernel unused and unchanged during the operatio=
n of 'makedumpfile', so they appear correctly in the dump as they were at t=
he time of the panic.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;- I don't know how IOMMU translation tables look=
 like, but are new DMA<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&nbsp; zones setup by drivers in second kernel p=
art of same table?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Yes. The copied translation tables in the kdump kern=
el contain both the translations that were active at the time of the dump (=
which will never go away until the dump is finished and the platform is reb=
ooted), plus any translations needed
 by the kdump kernel (which come and go as necessary).&nbsp; As the &quot;b=
ookkeeping&quot; structures are created in the new kernel (typically the fi=
rst time that a device requests a translation for a buffer) they are initia=
lized such that all IOVAs that already exist in
 the translate tables for tht device are marked as &quot;not available for =
allocation&quot; so all requests by device drivers in the new kernel receiv=
e IOVAs that were not in-use at the time of the panic.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt; How do we<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&nbsp; make sure that sufficient space is availa=
ble.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So far I have not seen any problem with running out =
of space because of this copy; &nbsp;however, I believe that this may be a =
valid concern with very large IO configurations -- and it deserves some att=
ention as the community reviews and tests
 this patch.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt; I am not sure if possible<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&nbsp; table corruption from crashed kernel is a=
n issue here or not.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any corrupted translation tables from the crashed ke=
rnel would be a problem that would prevent using copies of them. I hope and=
 expect that this happens rarely -- and that we would catch it during the c=
opy when it does.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fortunately, these tables are only manipulated by th=
e code in intel-iommu.c - which limits the amount of code that has to be &q=
uot;right&quot;.&nbsp; Of course, there is always the possibility that othe=
r code in the kernel could &quot;hose&quot; one of these tables
 -- so we need to sanity-check the tables before the new kernel uses them.<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;In general, I think changelogs of these patches =
need to be little better.<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;There seem to be lot of text and still I can't q=
uickly wrap my head around what a particular patch is supposed to be doing.=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I will work on the changelogs as I re-arrange the co=
de and the structure of the patch-set for the next submitted version.<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;But we definitely need to fix this issue. IOMMU =
issues with kdump have been troubling us for a very long time.<o:p></o:p></=
p>
<p class=3D"MsoNormal">Strongly agree.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-- Bill<o:p></o:p></p>
</div>
</body>
</html>

--_000_875D89B79D1D86448A583A7302C022A066E09397G4W3212americas_--

--===============5880647866108602385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5880647866108602385==--
