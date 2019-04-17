From: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Date: Wed, 17 Apr 2019 11:33:03 -0600
Message-ID: <8d314750-251c-7e6a-7002-5df2462ada6b@oracle.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190417170918.GA68678@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave@sr71.net>, linux-doc@vger.kernel.org, linux-mm@kvack.org, deepa.srinivasan@oracle.com, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, tycho@tycho.ws, x86@kernel.org, iommu@lists.linux-foundation.org, jsteckli@amazon.de, Arjan van de Ven <arjan@infradead.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, konrad.wilk@oracle.com, jcm@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, boris.ostrovsky@oracle.com, chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org, Khalid Aziz <khalid@gonehiking.org>, juergh@gmail.com, andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, tyhicks@canonical.com, linux-security-module@vger.kernel.org, Juerg Haefliger <juerg.haefliger@canonical.com>, keescook@google.com, Andrew Morton <akpm@linux-foundation.org>, Linus
List-Id: iommu@lists.linux-foundation.org

On 4/17/19 11:09 AM, Ingo Molnar wrote:
> 
> * Khalid Aziz <khalid.aziz@oracle.com> wrote:
> 
>>> I.e. the original motivation of the XPFO patches was to prevent execution 
>>> of direct kernel mappings. Is this motivation still present if those 
>>> mappings are non-executable?
>>>
>>> (Sorry if this has been asked and answered in previous discussions.)
>>
>> Hi Ingo,
>>
>> That is a good question. Because of the cost of XPFO, we have to be very
>> sure we need this protection. The paper from Vasileios, Michalis and
>> Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
>> does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.1
>> and 6.2.
> 
> So it would be nice if you could generally summarize external arguments 
> when defending a patchset, instead of me having to dig through a PDF 
> which not only causes me to spend time that you probably already spent 
> reading that PDF, but I might also interpret it incorrectly. ;-)

Sorry, you are right. Even though that paper explains it well, a summary
is always useful.

> 
> The PDF you cited says this:
> 
>   "Unfortunately, as shown in Table 1, the W^X prop-erty is not enforced 
>    in many platforms, including x86-64.  In our example, the content of 
>    user address 0xBEEF000 is also accessible through kernel address 
>    0xFFFF87FF9F080000 as plain, executable code."
> 
> Is this actually true of modern x86-64 kernels? We've locked down W^X 
> protections in general.
> 
> I.e. this conclusion:
> 
>   "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and 
>    triggering the kernel to dereference it, an attacker can directly 
>    execute shell code with kernel privileges."
> 
> ... appears to be predicated on imperfect W^X protections on the x86-64 
> kernel.
> 
> Do such holes exist on the latest x86-64 kernel? If yes, is there a 
> reason to believe that these W^X holes cannot be fixed, or that any fix 
> would be more expensive than XPFO?

Even if physmap is not executable, return-oriented programming (ROP) can
still be used to launch an attack. Instead of placing executable code at
user address 0xBEEF000, attacker can place an ROP payload there. kfptr
is then overwritten to point to a stack-pivoting gadget. Using the
physmap address aliasing, the ROP payload becomes kernel-mode stack. The
execution can then be hijacked upon execution of ret instruction. This
is a gist of the subsection titled "Non-executable physmap" under
section 6.2 and it looked convincing enough to me. If you have a
different take on this, I am very interested in your point of view.

Thanks,
Khalid
