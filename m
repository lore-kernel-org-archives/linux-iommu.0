From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Problem with ethernet/sound with IOMMU enabled on M5A99FX pro
	r2.0	motherboard
Date: Thu, 7 Mar 2013 09:25:18 -0600
Message-ID: <5138B15E.6000302@amd.com>
References: <1362510652.3171.YahooMailClassic@web120705.mail.ne1.yahoo.com>,
	<2004654126.1428743.1362596937686.JavaMail.root@redhat.com>
	<498F3735-A671-4FEA-A612-4BACF08DCE15@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0293251793173895190=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <498F3735-A671-4FEA-A612-4BACF08DCE15-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============0293251793173895190==
Content-Type: multipart/alternative;
	boundary="------------020709040409080301050906"

--------------020709040409080301050906
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Would you please provide the kernel log and the dump of ACPI (from tools 
like "acpidump")?  These should help debugging the issue.

Thank you,

Suravee
>> *From:* Donald Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org <mailto:ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>>
>> *Date:* March 7, 2013, 3:08:57 AM GMT+08:00
>> *To:* JapHack <japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org <mailto:japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>>
>> *Cc:* <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org 
>> <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>>
>> *Subject:* *Re: Problem with ethernet/sound with IOMMU enabled on 
>> M5A99FX pro r2.0 motherboard*
>>
>> Probably a missing IVMD block for the sound device.
>>
>> The ethernet device issue could be a driver issue --
>> DMA write to a page that was mapped for read-only.
>> Providing the IO page fault message would help to
>> diagnose further.
>>
>> - DonD
>>
>> ----- Original Message -----
>> From: "JapHack" <japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org <mailto:japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>>
>> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org 
>> <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
>> Sent: Tuesday, March 5, 2013 2:10:52 PM
>> Subject: Problem with ethernet/sound with IOMMU enabled on M5A99FX 
>> pro r2.0    motherboard
>>
>>
>> I recently bought this board as I wanted to start doing pci 
>> passthrough emulation.
>>
>> I noticed that after I had installed it and booted up, with IOMMU 
>> enabled
>> the network would work fine for a while then I would get an AMD-Vi IO 
>> page fault
>> and the driver would crash.
>> IF I turn off IOMMU there is no problem with using ethernet,
>>
>> The onboard ethernet chip is a RTL8111F/8168F.
>> For now I've turned off the network adapter in the bios and am using 
>> an add on card.
>>
>> Then I noticed that I could not use the onboard audio with oss 
>> (4.2.2007) with IOMMU
>> enabled. Alsa works ok, but I prefer to use oss. As with the ethernet 
>> card if I turn off
>> IOMMU in the bios the onboard audio is recognized and works fine.
>>
>> Any clues or help would be appreciated
>> Thanks, Don
>>
>> _______________________________________________
>> iommu mailing list
>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org 
>> <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>> _______________________________________________
>> iommu mailing list
>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org 
>> <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>


--------------020709040409080301050906
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Hi,<br>
    <br>
    Would you please provide the kernel log and the dump of ACPI (from
    tools like "acpidump")?&nbsp; These should help debugging the issue.<br>
    <br>
    Thank you,<br>
    <br>
    Suravee<br>
    <blockquote cite="mid:498F3735-A671-4FEA-A612-4BACF08DCE15-5C7GfCeVMHo@public.gmane.org"
      type="cite">
      <blockquote type="cite">
        <div><b>From:</b> Donald Dutile &lt;<a moz-do-not-send="true"
            href="mailto:ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
          <b>Date:</b> March 7, 2013, 3:08:57 AM GMT+08:00<br>
          <b>To:</b> JapHack &lt;<a moz-do-not-send="true"
            href="mailto:japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org">japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org</a>&gt;<br>
          <b>Cc:</b> &lt;<a moz-do-not-send="true"
            href="mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a>&gt;<br>
          <b>Subject:</b> <b>Re: Problem with ethernet/sound with IOMMU
            enabled on M5A99FX pro r2.0 motherboard</b><br>
          <br>
        </div>
      </blockquote>
      <blockquote type="cite">
        <div><span>Probably a missing IVMD block for the sound device.</span><br>
          <span></span><br>
          <span>The ethernet device issue could be a driver issue -- </span><br>
          <span>DMA write to a page that was mapped for read-only.</span><br>
          <span>Providing the IO page fault message would help to</span><br>
          <span>diagnose further.</span><br>
          <span></span><br>
          <span>- DonD</span><br>
          <span></span><br>
          <span>----- Original Message -----</span><br>
          <span>From: "JapHack" &lt;<a moz-do-not-send="true"
              href="mailto:japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org">japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org</a>&gt;</span><br>
          <span>To: <a moz-do-not-send="true"
              href="mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a></span><br>
          <span>Sent: Tuesday, March 5, 2013 2:10:52 PM</span><br>
          <span>Subject: Problem with ethernet/sound with IOMMU enabled
            on M5A99FX pro r2.0 &nbsp; &nbsp;motherboard</span><br>
          <span></span><br>
          <span></span><br>
          <span>I recently bought this board as I wanted to start doing
            pci passthrough emulation.
          </span><br>
          <span></span><br>
          <span>I noticed that after I had installed it and booted up,
            with IOMMU enabled </span>
          <br>
          <span>the network would work fine for a while then I would get
            an AMD-Vi IO page fault
          </span><br>
          <span>and the driver would crash. </span><br>
          <span>IF I turn off IOMMU there is no problem with using
            ethernet, </span><br>
          <span></span><br>
          <span>The onboard ethernet chip is a RTL8111F/8168F. </span><br>
          <span>For now I've turned off the network adapter in the bios
            and am using an add on card.
          </span><br>
          <span></span><br>
          <span>Then I noticed that I could not use the onboard audio
            with oss (4.2.2007) with IOMMU
          </span><br>
          <span>enabled. Alsa works ok, but I prefer to use oss. As with
            the ethernet card if I turn off
          </span><br>
          <span>IOMMU in the bios the onboard audio is recognized and
            works fine. </span><br>
          <span></span><br>
          <span>Any clues or help would be appreciated </span><br>
          <span>Thanks, Don </span><br>
          <span></span><br>
          <span>_______________________________________________</span><br>
          <span>iommu mailing list</span><br>
          <span><a moz-do-not-send="true"
              href="mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a></span><br>
          <span><a moz-do-not-send="true"
              href="https://lists.linuxfoundation.org/mailman/listinfo/iommu">https://lists.linuxfoundation.org/mailman/listinfo/iommu</a></span><br>
          <span>_______________________________________________</span><br>
          <span>iommu mailing list</span><br>
          <span><a moz-do-not-send="true"
              href="mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a></span><br>
          <span><a moz-do-not-send="true"
              href="https://lists.linuxfoundation.org/mailman/listinfo/iommu">https://lists.linuxfoundation.org/mailman/listinfo/iommu</a></span><br>
          <span></span><br>
        </div>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------020709040409080301050906--

--===============0293251793173895190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0293251793173895190==--
