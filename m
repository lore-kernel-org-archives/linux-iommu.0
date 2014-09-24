From: Rob Roschewsk <gerard-1/SUfjJPYocsP9Te1NuDSQC/G2K4zDHf@public.gmane.org>
Subject: RE: [PATCH] iommu/vt-d: Fix broken device issue when using iommu=pt
Date: Wed, 24 Sep 2014 17:56:31 -0400 (EDT)
Message-ID: <1597491265.153338.1411595791727.JavaMail.open-xchange@oxuslxltgw04.lxa.perfora.net>
Reply-To: Rob Roschewsk <gerard-1/SUfjJPYocsP9Te1NuDSQC/G2K4zDHf@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4740933910685493678=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============4740933910685493678==
Content-Type: multipart/alternative;
	boundary="----=_Part_153337_1981567742.1411595791667"

------=_Part_153337_1981567742.1411595791667
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello All .... wonder if there has been any movement on this issue .... I'm
having a similar issue 
 
I'm running an HP dl380 gen 8 with an Emulex OneConnect 10Gb iSCSI (14e4:164c)
(rev 11)
also known as " Hewlett-Packard Company NC373i Integrated Multifunction Gigabit
Server Adapter"
 
03:00.2 Mass storage controller: Emulex Corporation OneConnect 10Gb iSCSI
Initiator (be3) (rev 01)

03:00.3 Mass storage controller: Emulex Corporation OneConnect 10Gb iSCSI
Initiator (be3) (rev 01)

Seems as soon as the iscsi target is contacted the following messages appear in
the log every few seconds ....

Sep 24 15:25:30  kernel: [ 78.682675] dmar: DRHD: handling fault status reg 2
Sep 24 15:25:30  kernel: [ 78.699797] dmar: DMAR:[DMA Write] Request device
[03:00.2] fault addr ffffc000
Sep 24 15:25:30  kernel: [ 78.699797] DMAR:[fault reason 05] PTE Write access is
not set
Sep 24 15:25:30  kernel: [ 78.934546] dmar: DRHD: handling fault status reg 102
Sep 24 15:25:30  kernel: [ 78.934549] dmar: DMAR:[DMA Write] Request device
[03:00.2] fault addr ffffc000
Sep 24 15:25:30  kernel: [ 78.934549] DMAR:[fault reason 05] PTE Write access is
not set
Sep 24 15:25:30  kernel: [ 78.935359] dmar: DRHD: handling fault status reg 202

If I pull intel_iommu=on out of the kernel command line the problem goes away.

System is running Ubuntu 14.04.1 LTS 

3.13.0-32-generic #57-Ubuntu SMP Tue Jul 15 03:51:08 UTC 2014 x86_64 x86_64
x86_64 GNU/Linux

Looking for help .... I'm not sure where I should be looking next ..... I need
SR-IOV for other adapters in the box.

I have a system up that I can pull any data from that might be required.

Thanks,

--> Rob

 
------=_Part_153337_1981567742.1411595791667
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 
  <style type="text/css">.mceResizeHandle {position: absolute;border: 1px solid black;background: #FFF;width: 5px;height: 5px;z-index: 10000}.mceResizeHandle:hover {background: #000}img[data-mce-selected] {outline: 1px solid black}img.mceClonedResizable, table.mceClonedResizable {position: absolute;outline: 1px dashed black;opacity: .5;z-index: 10000}
</style>
 
 </head><body style="">
 
  <div>
   Hello All .... wonder if there has been any movement on this issue .... I&#39;m&#160;having&#160;a similar issue&#160;
  </div> 
  <div>
   &#160;
  </div> 
  <div>
   I&#39;m&#160;running&#160;an HP dl380 gen 8 with an&#160;Emulex OneConnect 10Gb iSCSI (14e4:164c) (rev 11)
  </div> 
  <div>
   also known as &#34;
   <span style="font-size: 9pt;">Hewlett-Packard Company NC373i Integrated Multifunction Gigabit Server Adapter&#34;</span>
  </div> 
  <div>
   &#160;
  </div> 
  <div>
   <span style="font-size: 9pt;">03:00.2 Mass storage controller: Emulex Corporation OneConnect 10Gb iSCSI Initiator (be3) (rev 01)</span>
  </div> 
  <div> 
   <p>03:00.3 Mass storage controller: Emulex Corporation OneConnect 10Gb iSCSI Initiator (be3) (rev 01)</p> 
   <p>Seems as soon as the iscsi target is contacted the following messages&#160;appear in the log every few seconds ....</p> 
   <p>Sep 24 15:25:30 &#160;kernel: [ 78.682675] dmar: DRHD: handling fault status reg 2<br />Sep 24 15:25:30 &#160;kernel: [ 78.699797] dmar: DMAR:[DMA Write] Request device [03:00.2] fault addr ffffc000<br />Sep 24 15:25:30 &#160;kernel: [ 78.699797] DMAR:[fault reason 05] PTE Write access is not set<br />Sep 24 15:25:30 &#160;kernel: [ 78.934546] dmar: DRHD: handling fault status reg 102<br />Sep 24 15:25:30 &#160;kernel: [ 78.934549] dmar: DMAR:[DMA Write] Request device [03:00.2] fault addr ffffc000<br />Sep 24 15:25:30 &#160;kernel: [ 78.934549] DMAR:[fault reason 05] PTE Write access is not set<br />Sep 24 15:25:30 &#160;kernel: [ 78.935359] dmar: DRHD: handling fault status reg 202</p> 
   <p>If I pull intel_iommu=on out of the kernel command line the problem goes away.</p> 
   <p>System is running Ubuntu 14.04.1 LTS&#160;</p> 
   <p>3.13.0-32-generic #57-Ubuntu SMP Tue Jul 15 03:51:08 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux</p> 
   <p>Looking for help .... I&#39;m not sure where I should be looking next ..... I need SR-IOV for other adapters in the box.</p> 
   <p>I have a system up that I can pull any data from that might be required.</p> 
   <p>Thanks,</p> 
   <p>--&#62; Rob</p> 
   <p>&#160;</p> 
  </div>
 
</body></html>
------=_Part_153337_1981567742.1411595791667--

--===============4740933910685493678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4740933910685493678==--
