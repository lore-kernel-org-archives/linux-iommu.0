From: "Dominguez, Caesar" <caesar.dominguez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Problem: dmar: DRHD: handling fault status reg 3 on Red Hat 6.5
Date: Thu, 16 Jan 2014 01:11:22 +0000
Message-ID: <05480ADF32EBAC4D92944581B85B69422BE3ACB3@FMSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7287804732659267079=="
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
To: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============7287804732659267079==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_05480ADF32EBAC4D92944581B85B69422BE3ACB3FMSMSX103amrcor_"

--_000_05480ADF32EBAC4D92944581B85B69422BE3ACB3FMSMSX103amrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

When attempting to boot a fresh Red hat 6.5 installation, kernel constantly=
 show the following message.
If user uses 6.4, none of this issue is seen.

06] PTE Read access is not set
dmar: DRHD: handling fault status reg 3
dmar: DMAR:[DMA Read] Request device [00:02.0] fault addr 7f800000

This only is seeing on Red Hat 6.5, same system configuration using Red Hat=
 6.4, do not cause this issu
Current workaournd is to disable iommu
Using both options resolve the issue
Intel_iommu=3Digfx_off
Or
Intel_iommu=3Doff

I suspect of Kernel modules: i915, is there a Red Hat 6.5 bugzilla reportin=
g this or should I look for a i915 module?
Since same module is used on Red hat 6.4.

Details device [00:02.0]
00:02.0 VGA compatible controller: Intel Corporation Xeon E3-1200 v3 Proces=
sor Integrated Graphics Controller (rev 06) (prog-if 00 [VGA controller])
     Subsystem: Intel Corporation Device 2212
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin A routed to IRQ 16
     Region 0: Memory at c0000000 (64-bit, non-prefetchable) [size=3D4M]
     Region 2: Memory at b0000000 (64-bit, prefetchable) [size=3D256M]
     Region 4: I/O ports at 6000 [size=3D64]
     Expansion ROM at <unassigned> [disabled]
     Capabilities: [90] MSI: Enable- Count=3D1/1 Maskable- 64bit-
           Address: 00000000  Data: 0000
     Capabilities: [d0] Power Management version 2
           Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3h=
ot-,D3cold-)
          Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
     Capabilities: [a4] PCI Advanced Features
           AFCap: TP+ FLR+
           AFCtrl: FLR-
           AFStatus: TP-
     Kernel modules: i915




--_000_05480ADF32EBAC4D92944581B85B69422BE3ACB3FMSMSX103amrcor_
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
<p class=3D"MsoNormal">When attempting to boot a fresh Red hat 6.5 installa=
tion, kernel constantly show the following message.<o:p></o:p></p>
<p class=3D"MsoNormal">If user uses 6.4, none of this issue is seen.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">06] PTE Read access is not set<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">dmar: DRHD: handling fault status reg 3<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">dmar: DMAR:[DMA Read] Request device [00:02.0=
] fault addr 7f800000
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">This only is seeing on Red Hat 6.5, same syst=
em configuration using Red Hat 6.4, do not cause this issu<o:p></o:p></span=
></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Current workaournd is to disable iommu<o:p></=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Using both options resolve the issue<o:p></o:=
p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Intel_iommu=3Digfx_off<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Or<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Intel_iommu=3Doff<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">I suspect of Kernel modules: i915, is there a=
 Red Hat 6.5 bugzilla reporting this or should I look for a i915 module?<o:=
p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Since same module is used on Red hat 6.4.
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Details device [00:02.0]<o:p></o:p></span></p=
>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">00:02.0 VGA compatible controller: Intel Corp=
oration Xeon E3-1200 v3 Processor Integrated Graphics Controller (rev 06) (=
prog-if 00 [VGA controller])<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Intel Cor=
poration Device 2212<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; Control: I/O&#43; Me=
m&#43; BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- Fas=
tB2B- DisINTx-<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; Status: Cap&#43; 66M=
Hz- UDF- FastB2B&#43; ParErr- DEVSEL=3Dfast &gt;TAbort- &lt;TAbort- &lt;MAb=
ort- &gt;SERR- &lt;PERR- INTx-<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; Interrupt: pin A rou=
ted to IRQ 16<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; Region 0: Memory at =
c0000000 (64-bit, non-prefetchable) [size=3D4M]<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; Region 2: Memory at =
b0000000 (64-bit, prefetchable) [size=3D256M]<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; Region 4: I/O ports =
at 6000 [size=3D64]<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; Expansion ROM at &lt=
;unassigned&gt; [disabled]<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [90] M=
SI: Enable- Count=3D1/1 Maskable- 64bit-<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; Address: 00000000&nbsp; Data: 0000<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [d0] P=
ower Management version 2<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; Flags: PMEClk- DSI&#43; D1- D2- AuxCurrent=3D0mA PME(D0-,D1=
-,D2-,D3hot-,D3cold-)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&n=
bsp; Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [a4] P=
CI Advanced Features<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; AFCap: TP&#43; FLR&#43;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; AFCtrl: FLR-<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; AFStatus: TP-<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; Kernel modules: i915=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_05480ADF32EBAC4D92944581B85B69422BE3ACB3FMSMSX103amrcor_--

--===============7287804732659267079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7287804732659267079==--
